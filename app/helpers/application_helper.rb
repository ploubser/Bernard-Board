# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def get_plugins
        plugins = Dir.glob("app/views/griditems/plugins/**")
        plugins.each_with_index do |item, i|
            if item =~ /.*plugins\/(.+)/
                plugins[i] = $1.capitalize
            end
        end
        return plugins
    end

    def get_javascript
        javascript = Dir.glob("public/javascripts/*.js")
        javascript.each_with_index do |item, i|
            if item =~/.*javascripts\/(.+)/
                javascript[i] = $1
            end
        end
        return javascript
    end

    def get_stylesheets
        stylesheets = Dir.glob("public/stylesheets/*.css")
        stylesheets.each_with_index do |item, i|
            if item =~/.*stylesheets\/(.+)/
                stylesheets[i] = $1
            end
        end
        return stylesheets
    end
end
