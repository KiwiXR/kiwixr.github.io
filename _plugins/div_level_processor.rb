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
      # Loop through all <div> elements with an id
      content.scan(/<div[^>]*id=["']([^"']+)["'][^>]*>(.*?)<\/div>/mi) do |match|
        div_id = match[0]      # The id of the current <div>
        div_content = match[1] # The content inside the <div>
        # print match
        # Fetch defined components for the current div ID from the specific subdirectory
        defined_components = fetch_defined_components(components_base_dir, div_id)

        # Transform the div content based on defined components
        defined_components.each do |component|
          div_content.gsub!(/<#{component}([^>]*)>(.*?)<\/#{component}>/mi) do
            # print "#{$1}, #{$2}"
            "<custom-#{component}#{$1}>#{$2}</custom-#{component}>"
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
        File.basename(file, '.vue')[6..].downcase # Removes 'Custom' and converts to lowercase
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
  end
end
