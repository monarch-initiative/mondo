# What to do when the documentation fails to build

The Mondo pages are built managed using readthedocs.org at https://readthedocs.org/projects/mondo. Sometimes, the docs fail to rebuild. In order to debug this, go to https://readthedocs.org/projects/mondo/builds/. You will see something like this:

![image](https://user-images.githubusercontent.com/7070631/146690600-964b0c60-648e-4fe1-be2d-a985d9e74b7e.png)

Click on Failed to understand why the build is not progressing.


# How are the patterns rebuilt? 

Pattern documentation is auto-generated from the yaml patterns in src/patterns/dosdp-patterns. They are deployed here:
https://mondo.readthedocs.io/en/latest/editors-guide/patterns/.

Patterns are automatically rebuilding using GitHub actions: https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/docs.yaml. This action will create a pull request whenever a pattern is updated. It can also be run manually should that ever be necessary.



























































