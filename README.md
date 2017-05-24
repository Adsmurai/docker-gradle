# Adsmurai's Dockerized Gradle

This version of dockerized gradle is based on the
[official gradle's docker repository](https://hub.docker.com/_/gradle/), but it
has some extra nice features, like UIDs and GIDs mapping.

## Usage instructions

For example, if you want to execute the build task
```bash
docker run                                               \
       --rm                                              \
       -it                                               \
       -v /home/user/sourcedir/:/home/gradle/playground  \
       -e HOST_USER_ID=$(id -u)                          \
       -e HOST_GROUP_ID=$(id -g)                         \
       adsmurai/gradle:3.5                               \
       gradle build
```
