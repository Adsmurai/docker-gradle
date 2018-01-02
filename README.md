# Adsmurai's Dockerized Gradle

You can find the published images in
[our own docker repository](https://hub.docker.com/r/adsmurai/gradle/).

This version of dockerized gradle is inspired by the
[official gradle's docker repository](https://hub.docker.com/_/gradle/), but it
has some extra nice features, like UIDs and GIDs mapping.

## Usage instructions

For example, if you want to execute the build task
```bash
docker run                                                  \
       --rm                                                 \
       -it                                                  \
       -v /home/user/sourcedir/:/home/apprunner/playground  \
       -e HOST_USER_ID=$(id -u)                             \
       -e HOST_GROUP_ID=$(id -g)                            \
       adsmurai/gradle:4.4-jdk8                             \
       gradle build
```

## Extra tips

As you work with this dockerized utility, you will find that it always tries to
spawn a daemon in order to save resources on later builds. Because the way this
container works, Gradle will fail doing this. It won't crash, but it's annoying
to see the warning message every time.

In order to disable the daemon spawning step, you can modify the command to
something like this (notice the difference in the last line):

```bash
docker run                                                  \
       --rm                                                 \
       -it                                                  \
       -v /home/user/sourcedir/:/home/apprunner/playground  \
       -e HOST_USER_ID=$(id -u)                             \
       -e HOST_GROUP_ID=$(id -g)                            \
       adsmurai/gradle:4.4-jdk8                             \
       gradle -Dorg.gradle.daemon=false build
```
