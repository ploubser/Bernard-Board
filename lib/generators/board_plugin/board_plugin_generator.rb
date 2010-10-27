class BoardPluginGenerator < Rails::Generator::NamedBase
    attr_reader :plugin_name
    def initialize(runtime_args, runtime_options = {})
        super
        @plugin_name = file_name.underscore
    end

    def manifest
        @plugin_name = name
        record do |m|
            m.directory "vendor/plugins/bernard_#{@plugin_name}/"
            m.template "init.rb.erb", "vendor/plugins/bernard_#{@plugin_name}/init.rb"
            m.file "README", "vendor/plugins/bernard_#{@plugin_name}/REAMDE"
            
            m.directory "vendor/plugins/bernard_#{@plugin_name}/lib/"
            m.template "lib/helpers.rb.erb", "vendor/plugins/bernard_#{@plugin_name}/lib/#{@plugin_name}.rb"
            m.directory "vendor/plugins/bernard_#{@plugin_name}/lib/javascripts"
            m.directory "vendor/plugins/bernard_#{@plugin_name}/lib/stylesheets"
            m.directory "vendor/plugins/bernard_#{@plugin_name}/lib/views"
            m.template "lib/javascripts/javascripts.js.erb", "vendor/plugins/bernard_#{@plugin_name}/lib/javascripts/#{@plugin_name}.js"
            m.file "lib/stylesheets/stylesheets.css", "vendor/plugins/bernard_#{@plugin_name}/lib/stylesheets/#{@plugin_name}.css"
            m.file "lib/views/_formfor_plugin.html.erb", "vendor/plugins/bernard_#{@plugin_name}/lib/views/_formfor_#{@plugin_name}.html.erb"
            m.file "lib/views/view.html.erb", "vendor/plugins/bernard_#{@plugin_name}/lib/views/_#{@plugin_name}.html.erb"

            m.directory "vendor/plugins/bernard_#{@plugin_name}/test/"
            m.template "test/plugin_test.rb.erb", "vendor/plugins/bernard_#{@plugin_name}/test/#{@plugin_name}_test.rb"
            m.file "test/test_helper.rb", "vendor/plugins/bernard_#{@plugin_name}/test/test_helper.rb"

            m.directory "vendor/plugins/bernard_#{@plugin_name}/tasks/"
            m.template "tasks/plugin_tasks.rake.erb", "vendor/plugins/bernard_#{@plugin_name}/tasks/#{@plugin_name}_tasks.rake"

        end
    end

    protected 
        def banner
            "Usage: #{$0} board_plugin plugin_name"
        end
end
