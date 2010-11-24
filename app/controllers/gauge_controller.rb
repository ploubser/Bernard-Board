class GaugeController < ApplicationController
    def redraw_gauge
        div = ""
        value = ""
        if params[:id] =~/item(\d+)/
            div = "con#{$1}"
        end

        @parameters = {}
        params[:parameters].split(";").each do |p|
            tmp = p.split(/:/, 2)
            @parameters[tmp[0]] = tmp[1]
        end

        unless @parameters["remote"] == "true"
            tmp = File.open(@parameters["path"], 'r')
            value = tmp.gets() 
        else
            Net::HTTP.start(@parameters["url"]) do |http|
                resp = http.get("/#{@parameters["path"]}")
                value = resp.body
            end
        end

        render :update do |page|
            page << "redrawGauge(#{value}, '#{div}')"
        end
    end
end
