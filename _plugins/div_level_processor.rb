# frozen_string_literal: true
=begin
For a given id=app, this plugin iterates over all components under src/components/app/,
where components are expected to be formatted like Custom{TAG}.vue, the corresponding
tags like <custom-tag> are then used to decide full set of tags to override
to find out if the
=end
# frozen_string_literal: true

module Jekyll
  class DivLevelHook
    def self.process_content(content)
      components_base_dir = File.join(Dir.pwd, 'src', 'components')
      modified_content = content.dup # Create a copy of the content to modify
      # print content
      # Define mappings for combinational elements
      combination_mappings = {
        '<pre><code>' => '<custom-pre-code>',
        # Add more mappings here as needed
      }
      # Loop through all <div> elements with an id
      content.scan(/<div[^>]*id=["']([^"']+)["'][^>]*>(.*?)<\/div>/mi) do |match|
        div_id = match[0]      # The id of the current <div>
        div_content = match[1] # The content inside the <div>
        # puts match

        # Fetch defined components for the current div ID from the specific subdirectory
        defined_components = fetch_defined_components(components_base_dir, div_id)

        # Transform the div content based on defined components
        defined_components.each do |component_tags|
          # pattern 1: opening tags
          pattern_open = component_tags.map { |tag| "<#{tag}([^>]*)>" }.join

          # pattern 2: closing tags
          pattern_close = component_tags.reverse.map { |tag| "</#{tag}>" }.join
          pattern_regex = Regexp.new("#{pattern_open}.*?#{pattern_close}", Regexp::MULTILINE | Regexp::IGNORECASE)
          # puts pattern_regex
          scans = div_content.scan(pattern_regex)
          # puts scans

          scans.each do |elements|
            # init
            original_opening = ""
            original_closing = ""
            replacement_opening = "<custom"
            replacement_attrs = ""
            replacement_closing = "</custom"

            # process original tags
            component_tags.each_with_index do |tag, index|
              original_opening = original_opening + "<#{tag}#{elements[index]}>"
              original_closing = "</#{tag}>" + original_closing
            end

            # puts original_opening + original_closing

            # process replacement tags
            component_tags.each_with_index do |tag, index|
              replacement_opening = replacement_opening + "-#{tag}"
              replacement_attrs = replacement_attrs + " attr_#{tag}='#{elements[index].strip}'"
              replacement_closing = replacement_closing + "-#{tag}"
            end
            replacement_opening = "#{replacement_opening}#{replacement_attrs}>"
            replacement_closing = "#{replacement_closing}>"
            # puts replacement_opening + replacement_closing

            # do replacement
            div_content.gsub!(/#{original_opening}(.*?)#{original_closing}/mi) do
              # print "#{$1}"
              "#{replacement_opening}#{$1}#{replacement_closing}"
            end
          end


        end

        # print div_content

        # Replace the original <div> content with the transformed content
        modified_content.gsub!(/<div[^>]*id=["']#{div_id}["'][^>]*>.*?<\/div>/mi, "<div id='#{div_id}'>#{div_content}</div>")
      end

      modified_content # Return the modified content
    end

    def self.fetch_defined_components(components_base_dir, div_id)
      # Construct the path to the specific subdirectory for the div_id
      components_dir = File.join(components_base_dir, div_id)

      # Check for components defined in the specific subdirectory
      Dir.glob(File.join(components_dir, "Custom*.vue")).map do |file|
        File.basename(file, '.vue')[6..].split(/(?=[A-Z])/).map { |tag| tag.downcase } # Removes 'Custom' and converts to lowercase
      end
    end
  end
end

# Registering the post-render hook
Jekyll::Hooks.register([:pages, :posts], :post_render) do |post|
  # Only process if the output is HTML
  # print post.extname
  if %w[.html .md .markdown].include?(post.extname)
    post.output = Jekyll::DivLevelHook.process_content(post.output)
    # puts post.output
  end
end
