class BoardPluginGenerator < Rails::Generator::NamedBase
    attr_reader :plugin_name
    def initialize(runtime_args, runtime_options = {})
        super
        @plugin_name = file_name.underscore
    end

    def manifest
        @plugin_name = name
        record do |m|
            m.directory "vendor/plugins/#{@plugin_name}/"
            m.template "init.rb.erb", "vendor/plugins/#{@plugin_name}/init.rb"
            m.file "README", "vendor/plugins/#{@plugin_name}/REAMDE"
            
            m.directory "vendor/plugins/#{@plugin_name}/lib/"
            m.template "lib/helpers.rb.erb", "vendor/plugins/#{@plugin_name}/lib/#{@plugin_name}.rb"
            m.directory "vendor/plugins/#{@plugin_name}/lib/javascripts"
            m.directory "vendor/plugins/#{@plugin_name}/lib/stylesheets"
            m.directory "vendor/plugins/#{@plugin_name}/lib/views"
            m.file "lib/javascripts/javascripts.js", "vendor/plugins/#{@plugin_name}/lib/javascripts/#{@plugin_name}.js"
            m.file "lib/stylesheets/stylesheets.css", "vendor/plugins/#{@plugin_name}/lib/stylesheets/#{@plugin_name}.css"
            m.file "lib/views/_formfor_plugin.html.erb", "vendor/plugins/#{@plugin_name}/lib/views/_formfor_#{@plugin_name}.html.erb"
            m.file "lib/views/view.html.erb", "vendor/plugins/#{@plugin_name}/lib/views/#{@plugin_name}.html.erb"

            m.directory "vendor/plugins/#{@plugin_name}/test/"
            m.template "test/plugin_test.rb.erb", "vendor/plugins/#{@plugin_name}/test/#{@plugin_name}_test.rb"
            m.file "test/test_helper.rb", "vendor/plugins/#{@plugin_name}/test/test_helper.rb"

            m.directory "vendor/plugins/#{@plugin_name}/tasks/"
            m.template "tasks/plugin_tasks.rake.erb", "vendor/plugins/#{@plugin_name}/tasks/#{@plugin_name}_tasks.rake"

        end
    end
end
