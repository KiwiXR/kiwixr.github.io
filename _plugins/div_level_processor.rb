# frozen_string_literal: true

require 'nokogiri'

module Jekyll
  class DivLevelHook
    def self.process_content(content)
      components_base_dir = File.join(Dir.pwd, 'src', 'components')
      modified_content = content.dup

      # Parse the content with Nokogiri
      doc = Nokogiri::HTML::DocumentFragment.parse(modified_content)
      # puts 'doc', doc.document
      # puts(doc)
      # Loop through all <div> elements with an id
      divs = doc.css('div[id]')
      divs.each do |div|
        div_id = div['id']
        components_dir = File.join(components_base_dir, div_id)

        # Skip if the components directory doesn't exist
        next unless Dir.exist?(components_dir)

        # Fetch defined components for this div
        defined_components = fetch_defined_components(components_dir)
        # Whitelist components shall not be processed
        whitelist_components = fetch_whitelist_components(components_dir)
        # print(whitelist_components)
        # defined_components = [["h1"]]
        # print(defined_components)
        # Process tags inside this div
        process_components_in_div(div, defined_components, whitelist_components)
      end

      # Convert the document back to HTML
      modified_content = doc.to_html
      # puts modified_content
      modified_content
    end

    # Modify this method to parse the component file names correctly
    def self.fetch_defined_components(components_dir)
      Dir.glob(File.join(components_dir, '*.vue')).map do |file|
        filename = File.basename(file, '.vue')
        next unless filename.start_with?('Custom')

        # Extract the tag chain from the filename
        # For example, 'CustomPreCode' => ['pre', 'code']
        tags = filename.sub('Custom', '').split(/(?=[A-Z])/).map(&:downcase)
        tags
      end.compact
    end

    def self.fetch_whitelist_components(components_dir)
      Dir.glob(File.join(components_dir, '*.vue')).map do |file|
        filename = File.basename(file, '.vue')
        next if filename.start_with?('Custom')

        # Extract the tag chain from the filename
        # For example, 'CustomPreCode' => ['pre', 'code']
        tags = filename.split(/(?=[A-Z])/).join('-').downcase
        tags
      end.compact
    end

    def self.process_components_in_div(div, component_tags_list, component_whitelist)
      component_tags_list.each do |tags|
        process_tag_chains(div, tags, component_whitelist)
      end
    end

    def self.process_tag_nesting(node, tags, parent_attrs)
      if node.name != tags.first
        return nil
      end
      # puts parent_attrs
      # process the current node
      parent_attrs['name'] = "#{parent_attrs['name']}-#{tags.first}"
      current_attr = ""
      node.keys.each do |key|
        # if key.start_with?('ella_')
        #   parent_attrs[key] = node[key]
        #   next
        # end
        current_attr += "#{key}=\"#{node[key]}\" "
      end
      if current_attr != ''
        parent_attrs["attr_#{tags.first}"] = current_attr
      end

      tags_remaining = tags.dup[1..-1]
      # puts tags_remaining
      if tags_remaining.empty?
        new_node = Nokogiri::XML::Node.new(parent_attrs['name'], node.document)
        parent_attrs.keys.each do |key|
          if key.start_with?('attr')
            new_node[key] = parent_attrs[key]
          end
        end
        # puts new_node.name
        # puts new_node.inner_html
        # puts node.inner_html
        new_node.inner_html = node.inner_html
        # new_node.content = node.content
        # puts new_node
        return new_node
      end
      res = nil
      node.children.each do |child|
        res = process_tag_nesting(child, tags_remaining, parent_attrs)
        # NOTE that we do not consider parallel nesting, so break here to prevent error and only process the first
        break if res
      end
      return res
    end

    def self.process_tag_chains(div, tags, component_whitelist)
      # recursively search for tags
      queue = [div]
      # print(tags)
      until queue.empty?
        node = queue.shift

        next if component_whitelist.include?(node.name)

        # process
        if node.name == tags.first
          parent_attrs = {"name"=>"custom"}
          # puts "node: #{node}"
          new_node = process_tag_nesting(node, tags, parent_attrs)
          if new_node
            node.replace(new_node)
          end
          # puts "new node: #{new_node}"
        end

        next if node.children.empty?
        node.children.each do |child|
          queue.push(child)
        end
      end
    end
  end
end

# Registering the post-render hook
Jekyll::Hooks.register([:pages, :posts], :post_render) do |post|
  if %w[.html .md .markdown].include?(post.extname)
    post.output = Jekyll::DivLevelHook.process_content(post.output)
  end
end
