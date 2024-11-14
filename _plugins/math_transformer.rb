# frozen_string_literal: true

module Jekyll
  class MathTransformer
    PLACEHOLDER = "UNIQUE_DOUBLE_DOLLAR_PLACEHOLDER" # Placeholder for double-dollar math

    # Method to process the content of a page or post
    def self.process_content(content)
      # Step 1: Apply math transformation to the raw Markdown content
      content = transform_math(content)

      # Return the transformed content (Markdown)
      content
    end

    # Method to transform inline math expressions: single dollar to double dollar
    def self.transform_math(input)
      # Step 1: Replace all double-dollar math ($$...$$) with the placeholder
      content = input.gsub("$$", PLACEHOLDER)

      # Step 2: Replace single-dollar math ($...$) with double-dollar math ($$...$$)
      content = content.gsub("$", "$$")

      # Step 3: Replace placeholders back with double dollars
      content = content.gsub(PLACEHOLDER, "$$")

      content
    end
  end
end

# Registering the pre-render hook to process content before kramdown parses it
Jekyll::Hooks.register([:pages, :posts, :documents], :pre_render) do |post|
  if %w[.md .markdown].include?(post.extname)
    post.content = Jekyll::MathTransformer.process_content(post.content)
  end
end
