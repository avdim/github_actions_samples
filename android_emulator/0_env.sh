#!/usr/bin/env bash

export SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
export ANDROID_HOME="$PWD/android-sdk"
export ANDROID_VERSION=29
export ANDROID_BUILD_TOOLS_VERSION=29.0.1
export ADB=$ANDROID_HOME/platform-tools/adb
export SDK_MANAGER=$ANDROID_HOME/tools/bin/sdkmanager
export EMULATOR=$ANDROID_HOME/emulator/emulator
export AVD_MANAGER=$ANDROID_HOME/tools/bin/avdmanager
