# Mondo website editing guidelines

_Updated 2019-08-19 by Nicole Vasilevsky_

## Instructions:
TODO: These instructions are out-of-date
1. In the terminal, navigate to your local directory, such as `cd git/mondo`
2. `git checkout gh-pages`
3. `git pull`
- it is recommended to do a pull request from the gh-pages branch
4. `bundle exec jekyll serve -l` - this will allow you to view the website in real time, as you make edits.
5. The output should look like below:

`Configuration file: /Users/vasilevs/git/mondo/_config.yml`  
`            Source: /Users/vasilevs/git/mondo`  
`       Destination: /Users/vasilevs/git/mondo/_site`  
` Incremental build: disabled. Enable with --incremental`  
`      Generating... `  
`Invalid theme folder: _sass`  
`      Remote Theme: Using theme mmistakes/minimal-mistakes`
`       Jekyll Feed: Generating feed for posts`
`        Pagination: Pagination is enabled, but I couldn't find an index.html page to use as the pagination template. Skipping pagination.`  
`   GitHub Metadata: No GitHub API authentication could be found. Some fields may be missing or have incorrect data.`  
`                    done in 4.67 seconds.`  
` Auto-regeneration: enabled for '/Users/vasilevs/git/mondo'`  
`LiveReload address: http://127.0.0.1:35729`  
`    Server address: http://127.0.0.1:4000/mondo/`  
`  Server running... press ctrl-c to stop. `  

6. Open the link [http://127.0.0.1:4000/mondo/](http://127.0.0.1:4000/mondo/). **Note**: you can right click on the URL and open URL
7. Make your changes to the website files.
8. Control c to end session
9. Commit changes to github:
`git add -A;git commit -m "update webpage";git push`
