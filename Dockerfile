########################################################################################################################
#                                                                                                                      #
#  WARNING:                                                                                                            #
#    This Docker image have been created only for development purposes, it is not advisable to use it in production    #
#    environments                                                                                                      #
#                                                                                                                      #
########################################################################################################################


FROM openjdk:8-jdk-alpine

LABEL maintainer "Andrés Correa Casablanca <andreu@adsmurai.com>"

ENV HOME /home/gradle
ENV GRADLE_USER_HOME /home/gradle/.gradle
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 3.5

ARG GRADLE_DOWNLOAD_SHA256=0b7450798c190ff76b9f9a3d02e18b33d94553f708ebc08ebe09bdf99111d110

RUN set -o errexit -o nounset                                                                                          \
	&& echo "Installing dependencies"                                                                                  \
	&& apk add --no-cache                                                                                              \
		bash                                                                                                           \
		libstdc++                                                                                                      \
	                                                                                                                   \
	&& echo "Installing build dependencies"                                                                            \
	&& apk add --no-cache --virtual .build-deps                                                                        \
		ca-certificates                                                                                                \
		openssl                                                                                                        \
		unzip                                                                                                          \
		wget                                                                                                           \
		gnupg                                                                                                          \
	                                                                                                                   \
	&& echo "Downloading Gradle"                                                                                       \
	&& wget -O gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"                 \
	                                                                                                                   \
	&& echo "Checking download hash"                                                                                   \
	&& echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum -c -                                                   \
	                                                                                                                   \
	&& echo "Installing Gradle"                                                                                        \
	&& unzip gradle.zip                                                                                                \
	&& rm gradle.zip                                                                                                   \
	&& mkdir /opt                                                                                                      \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/"                                                                 \
	&& ln -s "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle                                                               \
	                                                                                                                   \
	&& echo "Creating gradle user home"                                                                                \
	&& mkdir -p /home/gradle/.gradle                                                                                   \
	&& mkdir -p /home/gradle/playground                                                                                \
	                                                                                                                   \
	&& echo "Testing Gradle installation"                                                                              \
    && gradle --version                                                                                                \
                                                                                                                       \
    && echo "Install Gosu"                                                                                             \
    && GOSU_URL="https://github.com/tianon/gosu"                                                                       \
    && GOSU_VERSION="1.10"                                                                                             \
    && GNUPG_HOME="$(mktemp -d)"                                                                                       \
    && wget -O /usr/local/bin/gosu "$GOSU_URL/releases/download/$GOSU_VERSION/gosu-amd64"                              \
    && wget -O /usr/local/bin/gosu.asc "$GOSU_URL/releases/download/$GOSU_VERSION/gosu-amd64.asc"                      \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4                 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu                                                \
    && rm -r "$GNUPG_HOME" /usr/local/bin/gosu.asc                                                                     \
    && chmod +x /usr/local/bin/gosu                                                                                    \
    && gosu nobody true                                                                                                \
                                                                                                                       \
    && echo "Cleaning APK cache"                                                                                       \
    && apk del .build-deps

VOLUME /home/gradle/.gradle
WORKDIR /home/gradle/playground

COPY entry_point.sh /usr/local/bin/entry_point.sh
ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
CMD ["gradle"]
