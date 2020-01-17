#!/usr/bin/env bash

set -o xtrace

mkdir test_dir
touch test_dir/empty_file
ls -la test_dir

SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ANDROID_HOME="$PWD/android-sdk"
ANDROID_VERSION=29
ANDROID_BUILD_TOOLS_VERSION=29.0.1

ADB=$ANDROID_HOME/platform-tools/adb
SDK_MANAGER=$ANDROID_HOME/tools/bin/sdkmanager
EMULATOR=$ANDROID_HOME/emulator/emulator
AVD_MANAGER=$ANDROID_HOME/tools/bin/avdmanager

mkdir --mode 777 -p "$ANDROID_HOME" \
  && cd "$ANDROID_HOME" \
  && curl -o sdk.zip $SDK_URL > /dev/null 2>&1 & \
  && unzip -qq sdk.zip \
  && rm sdk.zip \
  && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

$ADB devices

$ANDROID_HOME/tools/bin/sdkmanager --update \
  && $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_VERSION}" "platform-tools"
  
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

