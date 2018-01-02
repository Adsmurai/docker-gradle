#!/usr/bin/env bash

export CONTAINER_GROUP_ID="${HOST_GROUP_ID:-1000}"
export CONTAINER_USER_ID="${HOST_USER_ID:-1000}"

# We first conditionally create the user's group
if grep -q "${CONTAINER_GROUP_ID}" /etc/group; then
    $(exit 0) ; # Group exists, nothing to do
else
    addgroup -g "${CONTAINER_GROUP_ID}" apprunner                                                                      ;
fi

# We obtain the user's group name
CONTAINER_GROUP_NAME=$(getent group "${CONTAINER_GROUP_ID}" | cut -d: -f1)

# We conditionally create the user we'll use to execute commands
$(exit $?)                                                                                                          && \
if getent passwd "${CONTAINER_USER_ID}" >/dev/null 2>&1; then
    $(exit 0) ; # User exists, nothing to do
else
    adduser -u "${CONTAINER_USER_ID}" -G "${CONTAINER_GROUP_NAME}" -H -h /home/apprunner -D apprunner               && \
    chown -R "${CONTAINER_USER_ID}":"${CONTAINER_GROUP_ID}" "${HOME}"                                                  ;
fi ;

$(exit $?)                                                                                                          && \
exec su-exec apprunner "$@"                                                                                            ;
