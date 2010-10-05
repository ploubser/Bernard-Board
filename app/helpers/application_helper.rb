# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def get_plugins
        plugins = Dir.glob("/home/psy/code/stomp/trunk/bernardboard/app/views/griditems/plugins/**")
        plugins.each_with_index do |item, i|
            if item =~ /.*plugins\/(.+)/
                plugins[i] = $1.capitalize
            end
        end
        return plugins
    end

    def get_javascript
        javascript = Dir.glob("/home/psy/code/stomp/trunk/bernardboard/public/javascripts/*.js")
        javascript.each_with_index do |item, i|
            if item =~/.*javascripts\/(.+)/
                javascript[i] = $1
            end
        end
        return javascript
    end
end
