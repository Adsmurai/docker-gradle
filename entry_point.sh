#!/usr/bin/env bash

# These two variables are only available in the scope of this script.
export CONTAINER_GROUP_ID="${HOST_GROUP_ID:-1000}"
export CONTAINER_USER_ID="${HOST_USER_ID:-1000}"

if id gradle >/dev/null 2>&1; then
    `exit 0` ; # User exists, nothing to do
else
    addgroup -g "${CONTAINER_GROUP_ID}" gradle                                                                      && \
    adduser -u "${CONTAINER_USER_ID}" -G gradle -h "${HOME}" -D gradle                                              && \
    chown gradle: "${HOME}"                                                                                            ;
fi ;

`exit $?` && exec /usr/local/bin/gosu gradle "$@"                                                                      ;
