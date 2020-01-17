#!/usr/bin/env bash

set -o xtrace

#Задать ANDROID_HOME если ещё не задано в системе
ANDROID_HOME=$ANDROID_HOME

ADB=$ANDROID_HOME/platform-tools/adb
SDK_MANAGER=$ANDROID_HOME/tools/bin/sdkmanager
EMULATOR=$ANDROID_HOME/emulator/emulator
AVD_MANAGER=$ANDROID_HOME/tools/bin/avdmanager

docker run --rm -p 6080:6080 -p 5565:5555 -p 5564:5554 --name avd29 --device /dev/kvm avdim/avd29
$ADB connect localhost:5565
$ADB devices
$ADB -e shell screencap /sdcard/screen.png
$ADB -e pull /sdcard/screen.png
