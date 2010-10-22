namespace :image do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_image/lib/views/* app/views/griditems/plugins/image"
        a = system "rsync -ruv vendor/plugins/bernard_image/lib/javascripts/* public/javascripts"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end

    task :remove do 
        a = system "rm -rf app/views/griditems/plugins/image" 
        a = system "rm public/javascripts/image.js" 
        a = system "rm public/stylesheets/image.css"
        if a == true
             system "echo '\n\nimage was removed'"
             system "echo '\nimage source can be deleted from /vendor/plugins/bernard_calendar' " 
        else
            system "echo '\n\nimage could not be removed'"
        end
    end
end
