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

### Install GitHub Desktop
Please make sure you have some kind of git client installed on your Machine. If you are new to Git, please install [GitHub Desktop](https://desktop.github.com/)

## Configure personal access token in GitHub

1. sign into [github.com]()
1. Go to settings
1. Click developer settings
1. Click personal access token
1. click: repo, user, workflow, write:packages
1. copy token
1. In terminal: nano .token

## Install Atom (text editor)

1. Click Atom-> Preferences
1. Click packages
1. Type 'whitespace' in the search bar
1. Set preferences per the image below

![whitespace](https://github.com/monarch-initiative/mondo/raw/master/docs/images/whitespace.png)


## Clone Mondo

1. Recommended to clone into a directory without white spaces in the path, for example, /users/me/git/mondo (me= your username), but avoid /users/me/git projects/mondo
2. In terminal: `git clone` https://github.com/monarch-initiative/mondo.git
4. Create mirror directory: `sh run.sh make dirs`
