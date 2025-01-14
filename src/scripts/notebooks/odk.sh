#!/bin/sh
# Wrapper script for docker.
#
# This is used primarily for wrapping the GNU Make workflow.
# Instead of typing "make TARGET", type "./run.sh make TARGET".
# This will run the make workflow within a docker container.
#
# Place this file in the folder from which you want to use the docker container.
# Note that the ODK will only be able to access files in that particular directory.
# 
# In your terminal, you first go to the directory that contains this wrapper
# script - then you can run 'sh odk.sh robot --version' to see if it works.
# For more experienced developers you can add the odk.sh file to you path and give it access
#
# To your entire user directory by adding '-v /Users/username/:/work'

VERSION=${VERSION:-v1.5.4}
docker pull obolibrary/odkfull:$VERSION
docker run -e ROBOT_JAVA_ARGS='-Xmx25G' -e JAVA_OPTS='-Xmx25G' -v $PWD/:/work -w /work --rm -ti obolibrary/odkfull:$VERSION "$@"
