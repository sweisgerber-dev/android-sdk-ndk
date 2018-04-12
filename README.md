# android-sdk-ndk

Docker image for building android apps with the SDK & NDK.

Contains:
 
- SDK API-Levels 21-27
- NDK & cmake
- Build, Platform & General Tools
- constraint-layout
- sets PATH &environment variables

See [Dockerfile](Dockerfile) for details

# Docker Hub

[sweisgerber/android-sdk-ndk](https://hub.docker.com/r/sweisgerber/android-sdk-ndk/)

``` bash
docker pull sweisgerber/android-sdk-ndk
```

# ENVIRONENT Variables

- `ANDROID_SDK_MAX="27"`
- `ANDROID_SDK_MIN="21"`
- `ANDROID_BUILD_TOOLS="27.0.3"`
- `ANDROID_SDK_FOLDER="/android-sdk"`
- `ANDROID_HOME="/android-sdk"`
- `ANDROID_NDK_HOME="/android-sdk/ndk-bundle"`

## Build instructions

``` bash
docker build -t android-sdk-ndk .
```

## Run instructions

``` bash
docker run -i -t android-sdk-ndk
```
