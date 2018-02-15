########################################################################################################################
#                                                                                                                      #
#  WARNING:                                                                                                            #
#    This Docker image have been created only for development purposes, it is not advisable to use it in production    #
#    environments                                                                                                      #
#                                                                                                                      #
########################################################################################################################


FROM openjdk:8-jdk-alpine

LABEL maintainer "Andrés Correa Casablanca <andreu@adsmurai.com>"

ENV HOME /user
ENV GRADLE_USER_HOME /user/.murri/gradle
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 4.5.1

ARG GRADLE_DOWNLOAD_SHA256=3e2ea0d8b96605b7c528768f646e0975bd9822f06df1f04a64fd279b1a17805e

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
	&& echo "Testing Gradle installation"                                                                              \
    && gradle --version                                                                                                \
                                                                                                                       \
    && echo "Cleaning APK cache"                                                                                       \
    && apk del .build-deps

WORKDIR /app

COPY entry_point.sh /usr/local/bin/entry_point.sh
ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
CMD ["gradle"]
