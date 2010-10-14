namespace :feed do
    desc "Sync plugin files with Bernard-Board"
    task :sync do
        a = system "rsync -ruv vendor/plugins/feed/lib/views/* app/views/griditems/plugins/feed"
        a = system "rsync -ruv vendor/plugins/feed/lib/javascripts/* public/javascripts"
        if a == true
            system "echo '\n\nSync was successful!'"
        else
            system "echo '\n\nSync failed!"
        end
    end
end
