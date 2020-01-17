#!/usr/bin/env bash

. 0_env.sh
set -o xtrace

echo no | $AVD_MANAGER create avd --force --name testAvd --abi google_apis/x86_64 --package 'system-images;android-${ANDROID_VERSION};google_apis;x86_64' > /dev/null 2>&1 &
$EMULATOR -avd testAvd -no-window -no-boot-anim -no-audio -verbose > /dev/null 2>&1 &

sleep 200
$ADB devices