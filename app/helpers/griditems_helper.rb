module GriditemsHelper
    require 'net/http'
    require 'uri'
    require 'rubygems'
    require 'nokogiri'
   
    def get_remote_file(remote_server, file)
        Net::HTTP.start(remote_server) do |http|
            resp = http.get("/#{file}")
            return resp.body
        end
    end

end
