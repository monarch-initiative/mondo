docker run -v %cd%\:/work -w /work/ -e ROBOT_JAVA_ARGS="-Xmx8G" -e JAVA_OPTS="-Xmx8G" --rm -ti obolibrary/odkfull %*
