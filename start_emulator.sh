#!/usr/bin/env bash

kill_all_emulators() {
    adb devices | grep emulator | cut -f1 | while read line; do adb -s $line emu kill; done
}

set -o xtrace

#Задать ANDROID_HOME если ещё не задано в системе
ANDROID_HOME=$ANDROID_HOME

ADB=$ANDROID_HOME/platform-tools/adb
SDK_MANAGER=$ANDROID_HOME/tools/bin/sdkmanager
EMULATOR=$ANDROID_HOME/emulator/emulator
AVD_MANAGER=$ANDROID_HOME/tools/bin/avdmanager

$ADB kill-server
$SDK_MANAGER "emulator"
yes | $SDK_MANAGER "system-images;android-29;google_apis;x86_64" #default

echo no | $AVD_MANAGER create avd --force --name testAvd --abi google_apis/x86_64 --package 'system-images;android-29;google_apis;x86_64'

$EMULATOR -list-avds
kill_all_emulators
$EMULATOR -avd testAvd -no-audio > /dev/null 2>&1 &
#$EMULATOR -avd testAvd -no-audio -no-window > /dev/null 2>&1 &
adb devices
sleep 20

#adb -e shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > /tmp/screen.png

adb -e shell screencap /sdcard/screen.png
adb -e pull /sdcard/screen.png

