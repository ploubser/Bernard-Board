namespace :nagios do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_nagios/lib/views/* app/views/griditems/plugins/nagios"
        a = system "rsync -ruv vendor/plugins/bernard_nagios/lib/javascripts/* public/javascripts"
        a = system "rsync -ruv vendor/plugins/bernard_nagios/lib/stylesheets/* public/stylesheets"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end
end
