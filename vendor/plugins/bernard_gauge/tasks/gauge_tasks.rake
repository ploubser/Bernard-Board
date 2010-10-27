namespace :gauge do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_gauge/lib/views/* app/views/griditems/plugins/gauge"
        a = system "rsync -ruv vendor/plugins/bernard_gauge/lib/javascripts/* public/javascripts"
        a = system "rsync -ruv vendor/plugins/bernard_gauge/lib/gauge_controller.rb app/controllers"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end

    task :remove do
        a = system "rm -rf app/views/griditems/plugins/gauge"
        a = system "rm public/javascripts/gauge.js"
        a = system "rm public/stylesheets/gauge.css"
        if a == true
            system "echo '\n\ngauge was removed'" 
            system "echo '\ngauge source can be deleted from /vendor/plugins/bernard_gauge' "
        else
            system "echo '\n\ngauge could not be removed'"
        end
    end

end
