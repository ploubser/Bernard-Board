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

        #html.css('tr').each do |e|
        #    if e.to_s =~/.*statusEven.*|.*statusOdd.*/
         #       if e.inner_text =~/.*CRITICAL.*/
         #           color = "#FF0000" 
         #       elsif e.inner_text =~/.*WARNING.*/ && color != "#FF0000"  
         #           color = "#FFFF00" 
         #       else
         #           unless (color == "#FFFF00" || color == "#FF0000" )
         #               color = "#33FF00" 
         #           end
         #       end
         #   end
        #end
        total = 0
        error = 0
        warning = 0
        html.css('tr').each do |e|
            if e.to_s =~/.*statusEven.*|.*statusOdd.*/
                if e.inner_text =~/.*(\d*) CRITICAL.*/
                    error += $1.to_i
                elsif e.inner_text =~/.*(\d*) WARNING.*/
                    warning += $1.to_i
                else e.inner_text =~/.*(\d*) OK.*/
                    total += $1._to_i
                end
            end
        end

        #Circle is defined in nagios.css
        html_response = "<div class='ui-widget-header' style='text-align:center;'>#{title}</div>"
        if error > 0
            html_response += "<div><center><span class='circle' style='background:#FF0000;z-index:0'>#{error}</span></center><div>"
            html_reponse += "<div><center>#{error} Critical</center></div>"
        elsif warning > 0
            html_response += "<div><center><span class='circle' style='background:#FFFF00'>#{warning}</span></center><div>"
        else 
            html_response += "<div><center><span class='circle' style='background:#33FF00'>#{total}</span></center><div>"
        end

        circle = " 
            <body> 
            #{html_response}
            </table>
            </div> 
            </body>" 

        return circle

    end
end
