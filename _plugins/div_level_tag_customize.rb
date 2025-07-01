# frozen_string_literal: true

require 'nokogiri'

module Jekyll
  class DivLevelTagCustomize
    @special_tags = %w[table ul ol select li tr option dl dt dd]
    @whitespace_sensitive_tags = %w[pre code]
    def self.process_content(content)
      components_base_dir = File.join(Dir.pwd, 'src', 'components')
      modified_content = content.dup

      # puts content

      # Parse the content with Nokogiri
      doc = Nokogiri::HTML(modified_content)
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
        # Some special tags to be handled carefully
        special_tags = ["table"]
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
        raw_html = node.inner_html
        new_node.inner_html = raw_html

        # 针对空白敏感标签应用预设样式
        tag_name = tags.first
        if @whitespace_sensitive_tags.include?(tag_name)
          # puts raw_html
          processed_html = raw_html.gsub(/(\n|^)( +)/) do |match|
            # 将连续空格转换为单个元素
            spaces = $2
            "#{$1}<span class='indent-container' style='display:inline-block;width:#{spaces.length * 0.5}em'>" +
              "<span class='indent-char'></span>" * spaces.length +
              "</span>"
          end
          processed_html = processed_html.gsub(/\n/, '<br class="line-break">')
          # processed_html = processed_html.gsub(/ {2,}/) { |spaces| '&nbsp;' * spaces.length }
          # puts processed_html
          new_node.inner_html = processed_html

          # # 应用样式
          # if tag_config[:style]
          #   # 保留原有样式并追加新样式
          #   current_style = new_node['style'] || ''
          #   new_node['style'] = "#{current_style}; #{tag_config[:style]}".sub(/^; /, '')
          # end

          # # 应用其他属性
          # tag_config.each do |key, value|
          #   next if key == :style # 样式已单独处理
          #   new_node[key.to_s] = value unless new_node[key.to_s]
          # end
        end
        # new_node.content = node.content
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

    def self.process_special_tag(node, tag)
      if node.name != tag
        return nil
      end
      # puts parent_attrs
      # process the current node
      vue_attr = "vue:custom-#{tag}"
      node.set_attribute("is", vue_attr)
    end

    def self.process_tag_chains(div, tags, component_whitelist)
      # recursively search for tags
      unless (tags & @special_tags).empty?
        if tags.size > 1
          warn("#{tags} has more than one special tags in #{@special_tags}")
          return
        end
      end
      queue = [div]
      # print(tags)
      until queue.empty?
        node = queue.shift

        next if component_whitelist.include?(node.name)

        # process
        if tags.size == 1 and node.name == tags.first and @special_tags.include?(tags.first)
          process_special_tag(node, tags.first)
        elsif node.name == tags.first
          parent_attrs = { "name" => "custom" }
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
Jekyll::Hooks.register([:pages, :posts, :documents], :post_render) do |post|
  if %w[.html .md .markdown].include?(post.extname)
    post.output = Jekyll::DivLevelTagCustomize.process_content(post.output)
    # puts post.output
  end
end
