#!/usr/bin/env bash

########################################################################################################################
# We disable Gradle's daemon via settings.                                                                             #
# This step is done here (and not in the image building process) because the directory /home/apprunner/.gradle could   #
# be mapped as an external volume when we want to make use of gradle's cache.                                          #
########################################################################################################################
if [[ ! -f "${GRADLE_USER_HOME}/gradle.properties" ]]; then
    echo "org.gradle.daemon=false" > /home/apprunner/.gradle/gradle.properties                                         ;
fi

$@ ;
