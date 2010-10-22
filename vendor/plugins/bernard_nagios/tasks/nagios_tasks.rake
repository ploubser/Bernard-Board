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

    task :remove do
        a = system "rm -rf app/views/griditems/plugins/nagios"
        a = system "rm public/javascripts/nagios.js"
        a = system "rm public/stylesheets/nagios.css"
        if a == true
             system "echo '\n\nnagios was removed'"  
             system "echo '\nnagios source can be deleted from /vendor/plugins/bernard_nagios' " 
        else
            system "echo '\n\nnagios could not be removed'" 
        end
    end

end
