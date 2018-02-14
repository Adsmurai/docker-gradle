#!/usr/bin/env bash

########################################################################################################################
# We disable Gradle's daemon via settings.                                                                             #
# This step is done here (and not in the image building process) because the directory /home/apprunner/.gradle could   #
# be mapped as an external volume when we want to make use of gradle's cache.                                          #
########################################################################################################################
if [[ ! -f "${GRADLE_USER_HOME}/gradle.properties" ]]; then
    if [[ -d "${GRADLE_USER_HOME}" ]]; then
        mkdir -p "${GRADLE_USER_HOME}"                                                                                 ;
    fi

    echo "org.gradle.daemon=false" > "${GRADLE_USER_HOME}/gradle.properties"                                           ;
fi

$@ ;
