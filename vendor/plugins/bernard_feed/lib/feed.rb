module Feed
    require 'rss/1.0'
    require 'rss/2.0'

    def get_feed(path)
        begin
            content = ""
            path = path.gsub("http://","") 
            open("http://" + path) do |p|
                content = p.read
            end
            return RSS::Parser.parse(content, false)
        rescue Exception => e
            return "error"
        end
    end
end
