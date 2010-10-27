module Nagios
    require 'nokogiri'
    
    def nagios(url, username, password, title)
        #Check is url is valid.
        begin
            uri = URI.parse("http://#{url.gsub("http://", "")}") 
            http = Net::HTTP.new(uri.host, uri.port)
        rescue Exception => e
            return "error1"
        end
        color = ""

        #Authenticate the user. 
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth username, password
        #Get page from nagios
        response = http.request(request)
        if response.inspect =~/.*401.*/
            return "error2"
        end
        
        #Parse html response body
        html= Nokogiri::HTML(response.body)

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

        #Circle is defined in nagios.css
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
end
