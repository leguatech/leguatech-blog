    require 'rubygems'
    require 'rake'
    require 'rdoc'
    require 'date'
    require 'yaml'
    require 'tmpdir'
    require 'jekyll'
    require 'shellwords'

    desc "Generate blog files"
    task :generate do
      system "bundle exec jekyll build"
    end

    desc "Generate and publish blog to gh-pages"
    task :publish => [:generate] do
      Dir.mktmpdir do |tmp|
        #checkout master
        system "git checkout master"
        system "git add ."
        message = "Site updated at #{Time.now.utc}"
        system "git commit -am #{message.shellescape}"
        system "git push origin"

        #checkout gh-pages
        system "mv _site /Users/cinlo/Desktop/GitHub/temp"
        system "git checkout gh-pages"
        system "rm -rf *"
        system "mv /Users/cinlo/Desktop/GitHub/temp/_site/* /Users/cinlo/Desktop/GitHub/leguatech-blog"
        system "git add ."
        system "git commit -am #{message.shellescape}"
        system "git push origin gh-pages"

        # go back to master 
        system "git checkout master"
      end
    end