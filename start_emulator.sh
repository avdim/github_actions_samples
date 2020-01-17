#!/usr/bin/env bash

set -o xtrace

#Задать ANDROID_HOME если ещё не задано в системе
ANDROID_HOME=$ANDROID_HOME

SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ANDROID_HOME2="~/android-sdk-2"
ANDROID_VERSION=29
ANDROID_BUILD_TOOLS_VERSION=29.0.1

ADB=$ANDROID_HOME2/platform-tools/adb
SDK_MANAGER=$ANDROID_HOME2/tools/bin/sdkmanager
EMULATOR=$ANDROID_HOME2/emulator/emulator
AVD_MANAGER=$ANDROID_HOME2/tools/bin/avdmanager

mkdir --mode 777 -p $ANDROID_HOME2
touch $ANDROID_HOME2/test.txt
ls -la $ANDROID_HOME2

mkdir --mode 777 -p $ANDROID_HOME2 \
  && cd "$ANDROID_HOME2" \
  && curl -o sdk.zip $SDK_URL \
  && unzip -qq sdk.zip \
  && rm sdk.zip
#  && yes | $ANDROID_HOME2/tools/bin/sdkmanager --licenses

ls -la $ANDROID_HOME2

$ANDROID_HOME2/tools/bin/sdkmanager --update \
  && $ANDROID_HOME2/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_VERSION}" "platform-tools"
  
kill_all_emulators() {
    $ADB devices | grep emulator | cut -f1 | while read line; do $ADB -s $line emu kill; done
}

$ADB kill-server
$SDK_MANAGER "emulator"
yes | $SDK_MANAGER "system-images;android-29;google_apis;x86_64" #default

echo no | $AVD_MANAGER create avd --force --name testAvd --abi google_apis/x86_64 --package 'system-images;android-29;google_apis;x86_64'

$EMULATOR -list-avds
kill_all_emulators
$EMULATOR -avd testAvd -no-window -no-boot-anim -no-audio -verbose > /dev/null 2>&1 &
#$EMULATOR -avd testAvd -no-audio -no-window > /dev/null 2>&1 &
$ADB devices
#./wait_for_emulator.sh
sleep 20

#$ADB -e shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > /tmp/screen.png

$ADB -e shell screencap /sdcard/screen.png
$ADB -e pull /sdcard/screen.png

