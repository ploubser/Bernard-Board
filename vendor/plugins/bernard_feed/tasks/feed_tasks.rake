namespace :feed do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/bernard_feed/lib/views/* app/views/griditems/plugins/feed"
        a = system "rsync -ruv vendor/plugins/bernard_feed/lib/javascripts/* public/javascripts"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end

    task :remove do  
        a = system "rm -rf app/views/griditems/plugins/feed"
        a = system "rm public/javascripts/feed.js" 
        a = system "rm public/stylesheets/feed.css"  
        if a == true
            system "echo '\n\nfeed was removed'"
            system "echo '\nfeed source can be deleted from /vendor/plugins/bernard_feed' "
        else
            system "echo '\n\nfeed could not be removed'" 
        end
    end
end
