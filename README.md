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

### Gradle's cache

In order to use the Gradle's cache, you can also mount a specific volume with
the option `-v volume_name:/home/apprunner/.gradle`.

We recommend to **NOT** mapping the equivalent directory inside the host
(`-v /home/host_username/.gradle:/home/apprunner/.gradle`) because the custom
entry point of this image explicitly disables the Gradle's daemon modifying
the settings files inside this directory.
