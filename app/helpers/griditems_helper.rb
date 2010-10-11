module GriditemsHelper
    require 'net/http'
    require 'uri'
    require 'rubygems'
    require 'nokogiri'
    require 'gcal4ruby'
    
    # Helper implements the nagios plugin
    def nagios(url, username, password, title)
        uri = URI.parse("http://#{url.gsub("http://", "")}")
        http = Net::HTTP.new(uri.host, uri.port)
        color = ""
        
        #Get page from nagios
        request = Net::HTTP::Get.new(uri.request_uri)
#       request.basic_auth 'psy', 'shuChahb'
        request.basic_auth username, password
        response = http.request(request)
        #Parse html response body
        html= Nokogiri::HTML(response.body)

        title = title
        #Critical - red
        #Warning - Yellow
        #All good - Green
        html.css('tr').each do |e|
            if e.to_s =~/.*statusEven.*|.*statusOdd.*/
                    if e.inner_text =~/.*CRITICAL.*/
                        color = "#FF0000"
                    elsif e.inner_text =~/.*WARNING.*/ && color != "#FF0000"
                        color = "#FFFF00"
                    else  
                        unless (color == "#FFFF00" || color == "#FF0000" )
                            color = "#33FF00"
                        end
                    end
            end
        end
        
        #Circle is defined in /public/stylesheets/bernard.css
        html_response = "<div class='ui-widget-header' style='text-align:center;'>#{title}</div>"
        html_response += "<div><center><span class='circle' style='background:#{color}'>&nbsp;</span></center><div>"
        circle = "
        <body>
        #{html_response}
        </table>
        </div>
        </body>"
        return circle
    end

    def calendar(username, password)
        service = GCal4Ruby::Service.new
        service.authenticate(username, password)
        return service.events
    end

    def get_remote_file(remote_server, file)
        Net::HTTP.start(remote_server) do |http|
            resp = http.get("/#{file}")
            RAILS_DEFAULT_LOGGER.debug resp.code
            return resp.body
        end
    end

end
