# Set up new computer 

For ontology curation and development on a Mac. 
We are assuming your default shell is zsh (modern machines use zsh as a shell, older machines use bash). 

## Install brew

1. https://brew.sh/

## Set up docker

- Follow the instructions [here](https://hub.docker.com/editions/community/docker-ce-desktop-mac). 
- Once installed, you should be able to open your command line and download the ODK.
  - Open Terminal
  - in the command line type, type `docker pull obolibrary/odkfull`. This will download the ODK (will take a few minutes, depending on you internet connection).

- Setting the memory: 
Set memory ~60% of your system memory, for example, if you have 16GB of RAM, then you should assign 10-11. 

![dockermemory](https://github.com/INCATools/ontology-development-kit/raw/master/docs/img/docker_memory.png)

## Install Java
note: brew install java has changed since a few months ago (early 2021)

`brew install java`

`echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> ~/.zshrc`

## Install GitHub Desktop
Please make sure you have some kind of git client installed on your Machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

## Configure personal access token in GitHub

1. sign into [github.com]()
1. Go to settings -> Click developer settings -> Click personal access token
      1. click: repo, user, workflow, write:packages _(see image below, note that the image is truncated)_
      1. Give the token a name that clearly state why this token will be used
      1. set the tolken to expire in 1 year (note that every year, you will have to create a new one)
      1. click "generate token" at the bottom of the page
      1. _Note that the image below is truncated_
         ![Screenshot 2023-09-13 at 11 46 45](https://github.com/monarch-initiative/mondo/assets/12737987/6617de87-2b30-4ef6-acf7-346c7433cd8e)

1. copy token
      1. make sure you copy and keep the token in a safe place, it is the only opportunity you will have to copy it
         
1. In terminal: nano .token
      1. this will open a window in which you can paste your token
      1. paste your token in this window, then save (Control O; enter) and close (Control X)
         
## Install Atom (text editor)

1. Click Atom-> Preferences
1. Click packages
1. Type 'whitespace' in the search bar
1. Set preferences per the image below

![whitespace](https://github.com/monarch-initiative/mondo/raw/master/docs/images/whitespace.png)


## Clone Mondo

1. Recommended to clone into a directory without white spaces in the path, for example, /users/me/git/mondo (me= your username), but avoid /users/me/git projects/mondo
1. In terminal: `git clone` https://github.com/monarch-initiative/mondo.git
1. Create mirror directory: `sh run.sh make dirs`

*Alternative cloning*
1. go to the [Mondo repository](https://github.com/monarch-initiative/mondo)
1. click on "code", then "Open with GitHub Desktop"
      1. ![Screenshot 2023-09-13 at 11 55 35](https://github.com/monarch-initiative/mondo/assets/12737987/c7dd9684-9eb4-4e5c-b16a-63def104081c)
1. This will open a window in GitHub desktop and give you option for where to clone the repository on your machine.
![Screenshot 2023-09-13 at 12 04 45](https://github.com/monarch-initiative/mondo/assets/12737987/041d2402-d220-4157-84ae-9e9af084a36a)
1. Click "clone"
