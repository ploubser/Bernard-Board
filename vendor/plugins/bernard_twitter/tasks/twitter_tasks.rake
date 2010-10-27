namespace :twitter do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_twitter/lib/views/* app/views/griditems/plugins/twitter"
        a = system "rsync -ruv vendor/plugins/bernard_twitter/lib/javascripts/* public/javascripts"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end

    task :remove do 
         a = system "rm -rf app/views/griditems/plugins/twitter"
         a = system "rm public/javascripts/twitter.js"
         a = system "rm public/stylesheets/twitter.css"
         if a == true
             system "echo '\n\ntwitter was removed'"
             system "echo '\ntwitter source can be deleted from /vendor/plugins/bernard_twitter' "
         else
             system "echo '\n\ntwitter could not be removed'"
         end
    end
end
