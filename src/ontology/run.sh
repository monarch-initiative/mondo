#!/bin/sh
# Wrapper script for docker.
#
# This is used primarily for wrapping the GNU Make workflow.
# Instead of typing "make TARGET", type "./run.sh make TARGET".
# This will run the make workflow within a docker container.
#
# The assumption is that you are working in the src/ontology folder;
# we therefore map the whole repo (../..) to a docker volume.
#
# See README-editors.md for more details.

docker pull obolibrary/odkfull:dev
docker pull obolibrary/odkfull:latest

IMAGE=${IMAGE:-odkfull:latest}
MEMORY_GB=${MEMORY_GB:-8}
MEMORY_JAVA="-Xmx${MEMORY_GB}G"
ODK_DEBUG=${ODK_DEBUG:-no}

echo "Running ODK with ${MEMORY_GB} GB of memory, using ${IMAGE}."

TIMECMD=
if [ x$ODK_DEBUG = xyes ]; then
    # If you wish to change the format string, take care of using
    # non-breaking spaces (U+00A0) instead of normal spaces, to
    # prevent the shell from tokenizing the format string.
    TIMECMD="/usr/bin/time -f ### DEBUG STATS ###\nElapsed time: %E\nPeak memory: %M kb"
fi

docker run --memory=${MEMORY_GB}g  -v $PWD/../../:/work -w /work/src/ontology -e ROBOT_JAVA_ARGS=${MEMORY_JAVA} -e JAVA_OPTS=${MEMORY_JAVA} --rm -ti obolibrary/$IMAGE $TIMECMD "$@"
