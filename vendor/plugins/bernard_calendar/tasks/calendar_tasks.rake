namespace :calendar do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_calendar/lib/views/* app/views/griditems/plugins/calendar"
        a = system "rsync -ruv vendor/plugins/bernard_calendar/lib/javascripts/* public/javascripts"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end

    task :remove do 
        a = system "rm -rf app/views/griditems/plugins/calendar"
        a = system "rm public/javascripts/calendar.js"
        a = system "rm public/stylesheets/calendar.css"
        if a == true
            system "echo '\n\ncalendar was removed'" 
            system "echo '\ncalendar source can be deleted from /vendor/plugins/bernard_calendar' "
        else
             system "echo '\n\ncalendar could not be removed'"
        end
    end
end
