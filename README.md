# Adsmurai's Dockerized Gradle

You can find the published images in
[our own docker repository](https://hub.docker.com/r/adsmurai/gradle/).

This version of dockerized gradle is inspired by the
[official gradle's docker repository](https://hub.docker.com/_/gradle/), but it
has some extra nice features, like UIDs and GIDs mapping.

## Usage instructions

### For Gradle >= 4.5

```bash

# Assuming that there is a volume named `gradle_cache` to store
# the Gradle's cache.

docker run                                                  \
       --rm                                                 \
       -it                                                  \
       -v "${HOME}:/user"                                   \
       -v gradle_cache:/user/.gradle                        \
       -v /home/user/sourcedir/:/app                        \
       -u "$(id -u):$(id -g)"                               \
       adsmurai/gradle:4.5-jdk8                             \
       gradle build
```

### For Gradle <= 4.4

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

In order to use the Gradle's cache, you can mount a specific volume with the
option `-v volume_name:/user/.gradle`.

We recommend to **NOT** mapping the equivalent directory inside the host
(`-v /home/host_username/.gradle:/user/.gradle`) because the custom entry point
of this image explicitly disables the Gradle's daemon modifying the settings
files inside this directory.
