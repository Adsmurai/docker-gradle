########################################################################################################################
#                                                                                                                      #
#  WARNING:                                                                                                            #
#    This Docker image have been created only for development purposes, it is not advisable to use it in production    #
#    environments                                                                                                      #
#                                                                                                                      #
########################################################################################################################


FROM openjdk:8-jdk-alpine

LABEL maintainer "Andrés Correa Casablanca <andreu@adsmurai.com>"

ENV HOME /home/apprunner
ENV GRADLE_USER_HOME /home/apprunner/.gradle
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 4.4.1

ARG GRADLE_DOWNLOAD_SHA256=e7cf7d1853dfc30c1c44f571d3919eeeedef002823b66b6a988d27e919686389

RUN set -o errexit -o nounset                                                                                          \
	&& echo "Installing dependencies"                                                                                  \
	&& apk add --no-cache                                                                                              \
		bash                                                                                                           \
		libstdc++                                                                                                      \
		su-exec                                                                                                        \
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
	&& mkdir -p /home/apprunner/.gradle                                                                                \
	&& mkdir -p /home/apprunner/playground                                                                             \
	                                                                                                                   \
	&& echo "Testing Gradle installation"                                                                              \
    && gradle --version                                                                                                \
                                                                                                                       \
    && echo "Cleaning APK cache"                                                                                       \
    && apk del .build-deps

VOLUME /home/apprunner/.gradle
WORKDIR /home/apprunner/playground

COPY entry_point.sh /usr/local/bin/entry_point.sh
ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
CMD ["gradle"]
