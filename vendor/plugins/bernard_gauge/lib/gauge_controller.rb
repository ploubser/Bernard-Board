class GaugeController < ApplicationController
    def get_gaugejson
        RAILS_DEFAULT_LOGGER.debug params["url"]
        uri = URI.parse(params["url"])
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        respond_to do |format|
            format.json {render :json => response.body}
        end
    end
end
