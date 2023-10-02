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


## Docker based instructions

- Checkout the gh-pages branch and cd to it
- Run `docker run --name mondo-docs -p "4000:4000" -p "35729:35729" --volume="$(pwd):/srv/jekyll:Z" -it jekyll/jekyll bash`
  - This will put you in a ternminal inside the Docker container in the working directory
  - `ls` should show you the Mondo doc files
- Run `jekyll build` if you want a one time build
- Run `jekyll serve -l` if you want a continuous build and the site served at localhost:4000 on your local machine.  Try to edit a doc file and you'll see the build update happening in the terminal. Once you see something like `...done in 3.704351825 seconds.` in the terminal, the browser should refresh automatically.
- Use `CTRL+C` to exid from the `jekyll serve` mode.
- Use `exit` to exit the Docker container. This will cause Docker to stop/exit the container but the container is still available for a later quicker start (as opposed to the initial startup with the docker run ... above). If you want to do another editing session later, and you've already done the above `docker run ....` before, you can use `docker start `docker start -ai mondo-docs` to get back into the already setup container and run the Jekyll commands above, or run anything else you can [see here](https://jekyllrb.com/docs/usage/)
- If you're all done with editing and do not want to keep the Docker container around, you can run `docker rm mondo-docs`. After doing this, you'll need to restart from `docker run ...` above next time.

