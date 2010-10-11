module Feed
    require 'rss/1.0'
    require 'rss/2.0'

    def get_feed(path)
        content = ""
        open(path) do |p|
            content = p.read
        end
        return RSS::Parser.parse(content, false)
    end
end
