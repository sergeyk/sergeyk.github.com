require 'tempfile'

module Jekyll
  class IpynbConverter < Converter
    safe true
    priority :high

    def matches(ext)
      ext =~ /ipynb/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      file = Tempfile.new('temp')
      name = File.basename file.path
      file.write(content)
      file.close
      begin
        # This outputs to a canonically named file in root directory.
        `ipython nbconvert --to html --template basic #{file.path}`

        # Jesus, for some reason the last letter is cut off.
        filename = Dir.getwd + "/#{name[0..-2]}.html"
        if not File.exists? filename
          raise("What the fuck #{name} #{filename}")
        end

        s = File.open(filename).read()
        "<div id='notebook'>#{s}</div>"
      rescue => e
        puts "ipynb conversion did not succeed: #{e.message}"
      ensure
        File.delete filename
      end
    end
  end
end
