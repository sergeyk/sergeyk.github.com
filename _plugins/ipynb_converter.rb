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
      file.write(content)
      file.close
      begin
        s = `ipython nbconvert basic_html #{file.path} --no-write --stdout`
        "<div id='notebook'>#{s}</div>"
      rescue => e
        puts "ipynb conversion did not succeed: #{e.message}"
      end
    end
  end
end
