# Mondo documentation website editing guidelines

_Updated 17-Jan-2024_

## Overview
These instructions are for updating the Mondo documentation website (this site). The files for the web site are contained within the <a href="https://github.com/monarch-initiative/mondo" target="_blank">mondo repo</a> and. The page content files are located under `/mondo/docs` and the website navigation content is located in the file `mondo/mkdocs.yml`. The Mondo documentation website is build using <a href="https://www.mkdocs.org/" target="_blank">MkDocs</a>.

## Prerequisites
- Clone the <a href="https://github.com/monarch-initiative/mondo" target="_blank">Mondo GitHub repo</a> locally 
- Install Docker following these <a href="https://oboacademy.github.io/obook/howto/setup-docker/" target="_blank">instructions</a>
- Python or Conda environment with `mkdocs` and `mkdocs-material` installed
```
pip install mkdocs
pip install mkdocs-material
```


## Instructions
Get the latest website files locally. This can either be done in the Terminal or using GitHub Desktop.

1. Navigate to the root of the mondo repo, e.g. `cd YOUR-LOCAL-DIRECTORY/mondo`
1. Fetch the latest content from `master`
1. Create a feature branch using the GitHub issue number as the branch name, e.g. issue-1234
1. Run the MkDocs server on your local computer by running this command (`mkdocs serve`) in your Terminal at the root of the cloned mondo repo (i.e. at the same directory level where the `mkdocs.yml` file is located). <br />To stop running the development server type Control+X Control+C in the Terminal.
1. Make edits to the pages and view the changes at: <a href="http://127.0.0.1:8000/" target="_blank">http://127.0.0.1:8000/</a>
1. Save the updated pages and commit the changes to the feature branch
1. Push the changes to the remote and create a Pull Request
