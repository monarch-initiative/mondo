# Mondo website editing guidelines

_Updated 04-Oct-2023_

## Overview
These instructions are for updating the Mondo Disease Ontology web site (https://mondo.monarchinitiative.org/). The files for the web site are contained within the `mondo` repo[1] and the web site files are in the `gh-pages` branch. A GitHub Action called `pages build and deployment` deploys the web site. The web site is built with Jekyll.

## Prerequisites
- Clone the Mondo GitHub repo[1] locally 
- Install Docker[2]


## Instructions
Get the latest web site files locally. This can either be done in the Terminal or using GitHub Desktop.

### Get the latest `gh-branches` files from the remote GitHub repo
#### Using Git from the Terminal
1. In the Terminal, navigate to your local directory, as:  
`cd git/mondo`
2. Checkout the branch that contains the web site files as:  
`git checkout gh-pages`
3. Get the latest updates for the branch from the remote as:  
`git pull`
(it is recommended to do a pull request from the gh-pages branch)

#### Using GitHub Desktop
1. Change the "Current Branch" to `gh-pages`
2. Click "Fetch origin" to pull the latest updates for the branch from the remote. 

### Run the web site server locally
If you already have Jekyll installed locally, you can follow these legacy instructions. Otherwise, skip to the section "Run the web site locally using Docker".  
1. `bundle exec jekyll serve -l` - this will allow you to view the website in real time, as you make edits.  
2. The output should look like below:  
```
Configuration file: /Users/vasilevs/git/mondo/_config.yml
            Source: /Users/vasilevs/git/mondo
       Destination: /Users/vasilevs/git/mondo/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
Invalid theme folder: _sass  
      Remote Theme: Using theme mmistakes/minimal-mistakes
       Jekyll Feed: Generating feed for posts
        Pagination: Pagination is enabled, but I couldn't find an index.html page to use as the pagination template. Skipping pagination.
GitHub Metadata: No GitHub API authentication could be found. Some fields may be missing or have incorrect data. 
                    done in 4.67 seconds.
 Auto-regeneration: enabled for '/Users/vasilevs/git/mondo'
LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000/mondo/
  Server running... press ctrl-c to stop.  
```
3. Open the link [http://127.0.0.1:4000/mondo/](http://127.0.0.1:4000/mondo/). **Note**: you can right click on the URL and open URL  
4. Make your changes to the website files.  
5. Control+C to end the session  
6. Commit changes to GitHub (example when working on Terminal):  
`git add -A;git commit -m "update webpage";git push`  
_NOTE:_ Since the web site is maintained on a branch, when changes are pushed to the remote this automatically triggers a GitHub Action to deploy the branch. There is no Pull Review step.


### Run the web site locally using Docker
1. Navigate to the mondo directory, e.g. `cd git/mondo`.

2. Confirm you are in the `gh-pages` branch and you have pulled the latest changes locally.

3. Run the web site server locally as:  
`docker run --name mondo-docs -p "4000:4000" -p "35729:35729" --volume="$(pwd):/srv/jekyll:Z" -it jekyll/jekyll bash`  
(this will put you in a ternminal inside the Docker container in the working directory)
- _NOTE_: If using an Apple processor (e.g. M1/M2), try running the command as below to avoid warning messages:  
`docker run --platform linux/amd64 --name mondo-docs -p "4000:4000" -p "35729:35729" --volume="$(pwd):/srv/jekyll:Z" -it jekyll/jekyll bash`

4. Once the Container is running, you can use common Linux commands to navigate the file hierarchy, e.g. `ls` should show you the Mondo doc files

5. Run `jekyll serve -l` to have a continuous build so that the local web site shows changes without having to refresh your browser (live reload).  
_NOTE_: Run `jekyll build` if you want a one time build

6. Open your browser to: `http://0.0.0.0:4000/`.   
 Try to edit a doc file and you'll see the build update happening in the terminal. Once you see something like `...done in 3.704351825 seconds.` in the terminal, the browser should refresh automatically.  

7. To exit from the `jekyll serve` mode, use `CTRL+C` to exit.

8. Type `exit` in the Terminal to exit the Docker container.  
This will cause Docker to stop/exit the container but the container is still available for a later quicker start (as opposed to the initial startup with the docker run ... above).   
- If you want to do another editing session later, and you've already done the above `docker run ....` steps earlier, you can use `docker start -ai mondo-docs` to get back into the already setup container and then run the Jekyll commands above (Step 5), or run anything else you can [see here](https://jekyllrb.com/docs/usage/)
- If you're all done with editing and do not want to keep the Docker container around, you can run `docker rm mondo-docs`. After doing this, you'll need to start from `docker run ...` (Step 3) next time.

9. Commit your edits to the `gh-pages` branch either using the Terminal or GitHub Desktop.  
10. Push your local changes to the remote.
_NOTE:_ Since the web site is maintained on a branch, when changes are pushed to the remote this automatically triggers a GitHub Action to deploy the branch. There is no Pull Review step.


## Resources
[1] https://github.com/monarch-initiative/mondo

[2] https://oboacademy.github.io/obook/howto/setup-docker/