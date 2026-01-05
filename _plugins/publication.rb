# _plugins/publication.rb
# Converts ```publication code blocks into HTML

module Jekyll
  class PublicationProcessor
    PUBLICATION_REGEX = /```publication\n(.*?)```/m
    REFERENCE_LINK_REGEX = /\[([^\]]+)\]\[([^\]]+)\]/
    INLINE_LINK_REGEX = /\[([^\]]+)\]\(([^\)]+)\)/
    BOLD_REGEX = /\*\*([^*]+)\*\*/

    def initialize(site)
      @site = site
      @references = load_references
    end

    def load_references
      refs = {}
      urls_file = File.join(@site.source, '_includes', 'peoples_urls.md')
      if File.exist?(urls_file)
        File.read(urls_file).scan(/\[(\w+)\]:\s*(\S+)/) do |key, url|
          refs[key] = url
        end
      end
      refs
    end

    def process(content)
      content.gsub(PUBLICATION_REGEX) do |_match|
        yaml_content = Regexp.last_match(1)
        parse_publication(yaml_content)
      end
    end

    def parse_publication(yaml_content)
      data = {}
      current_key = nil
      list_items = []

      yaml_content.each_line do |line|
        line = line.rstrip
        if line =~ /^(\w+):\s*(.*)$/
          # Save previous list if any
          if current_key == 'links' && !list_items.empty?
            data['links'] = list_items
            list_items = []
          end
          current_key = Regexp.last_match(1)
          value = Regexp.last_match(2)
          data[current_key] = value unless value.empty?
        elsif line =~ /^\s+-\s+(.+)$/ && current_key == 'links'
          list_items << Regexp.last_match(1)
        end
      end

      # Save final list
      data['links'] = list_items if current_key == 'links' && !list_items.empty?

      generate_html(data)
    end

    def resolve_markdown(text)
      return '' if text.nil? || text.empty?

      # Handle bold markers **text** -> <strong>text</strong>
      text = text.gsub(BOLD_REGEX) do |_match|
        "<strong>#{Regexp.last_match(1)}</strong>"
      end

      # Resolve reference links [text][ref]
      text = text.gsub(REFERENCE_LINK_REGEX) do |match|
        link_text = Regexp.last_match(1)
        ref_key = Regexp.last_match(2)
        url = @references[ref_key]
        if url
          # Check if link_text contains <strong> tags
          if link_text.include?('<strong>')
            link_text
              .gsub('<strong>', '')
              .gsub('</strong>', '')
              .then { |t| %(<strong><a href="#{url}">#{t}</a></strong>) }
          else
            %(<a href="#{url}">#{link_text}</a>)
          end
        else
          match # Leave unchanged if reference not found
        end
      end

      # Resolve inline links [text](url)
      text = text.gsub(INLINE_LINK_REGEX) do |_match|
        link_text = Regexp.last_match(1)
        url = Regexp.last_match(2)
        %(<a href="#{url}">#{link_text}</a>)
      end

      text
    end

    def generate_html(data)
      image = data['image'] || ''
      title = data['title'] || ''
      description = resolve_markdown(data['description'] || '')
      authors = resolve_markdown(data['authors'] || '')
      venue = data['venue'] || ''

      # Build links HTML
      links_html = ''
      if data['links']&.any?
        links_html = data['links'].map do |link|
          resolved = resolve_markdown(link)
          "[#{resolved}]"
        end.join("\n            ")
      end

      # Build content lines conditionally
      lines = []
      lines << "<strong>#{title}</strong>" unless title.empty?
      lines << description unless description.empty?
      lines << authors unless authors.empty?
      lines << venue unless venue.empty?
      lines << links_html unless links_html.empty?

      content_html = lines.join("\n            <br>\n            ")

      # Determine if image is a video file (handle query strings and fragments)
      media_html = if image.match?(/\.(mp4|webm|ogg)(\?.*)?$/i)
                     %(<video class="post--image" src="#{image}" autoplay loop muted playsinline></video>)
                   elsif image.empty?
                     ''
                   else
                     %(<img class="post--image" src="#{image}">)
                   end

      <<~HTML
        <div class="publication">
            #{media_html}
            <div>
                <p>
                    #{content_html}
                </p>
            </div>
        </div>
      HTML
    end
  end

  Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc|
    processor = PublicationProcessor.new(doc.site)
    doc.content = processor.process(doc.content)
  end
end
