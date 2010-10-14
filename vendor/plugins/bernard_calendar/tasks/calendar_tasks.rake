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
end
