FROM debian:stretch
# FROM debian:stretch-slim
# => couldn't use stretch-slim because of: `dpkg: dependency problems prevent configuration of ca-certificates-java`

MAINTAINER Sebastian Weisgerber <weisgerber@cispa.saarland>

ENV SDK_TOOLS_LINUX_WEB_VERSION="3859397"

ENV ANDROID_SDK_MAX="27"
ENV ANDROID_SDK_MIN="21"
ENV ANDROID_BUILD_TOOLS="27.0.3"
ENV ANDROID_NDK_CMAKE="3.6.4111459"
# ENV ANDROID_PLATFORM_TOOLS="27.0.1" # using most recent

ENV ANDROID_SDK_FOLDER="/android-sdk"
ENV ANDROID_HOME="${ANDROID_SDK_FOLDER}"
ENV ANDROID_NDK_HOME="${ANDROID_HOME}/ndk-bundle"

# Debian Installation
RUN apt-get update --yes
RUN apt-get install --yes apt-utils
RUN apt-get install --yes \
        wget \
        curl \
        tar \
        unzip \
        lib32stdc++6 \
        lib32z1 \
        openjdk-8-jdk \
        openjdk-8-jre
RUN apt-get upgrade --yes
RUN apt-get dist-upgrade --yes

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS_LINUX_WEB_VERSION}.zip
RUN mkdir -p ${HOME}/.android
RUN echo "count=0\n" > ${HOME}/.android/repositories.cfg
RUN mkdir -p ${ANDROID_SDK_FOLDER}
RUN unzip -d ${ANDROID_SDK_FOLDER} -qq android-sdk.zip

# SDK Installation
RUN ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager --list || true
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platform-tools"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "tools"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
# RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-27"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-26"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-25"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-24"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-23"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-22"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-21"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;android;m2repository"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;m2repository"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;google_play_services"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;instantapps"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;market_apk_expansion"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;market_licensing"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;webdriver"
#RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0"
#RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.1"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"
#RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0"
#RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
#RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "patcher;v4
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "ndk-bundle"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "cmake;${ANDROID_NDK_CMAKE}"
RUN echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager --licenses

ENV ANDROID_HOME="${ANDROID_SDK_FOLDER}"
ENV ANDROID_NDK_HOME="${ANDROID_HOME}/ndk-bundle"

ENV PATH="$PATH:${ANDROID_HOME}"
ENV PATH="$PATH:${ANDROID_HOME}/build-tools/${ANDROID_BUILD_TOOLS}/"
ENV PATH="$PATH:${ANDROID_HOME}/ndk-bundle/"
ENV PATH="$PATH:${ANDROID_HOME}/platform-tools/"
ENV PATH="$PATH:${ANDROID_HOME}/tools"
ENV PATH="$PATH:${ANDROID_HOME}/tools/bin"

CMD [ "bash" ]
