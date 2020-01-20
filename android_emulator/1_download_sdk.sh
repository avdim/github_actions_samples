#!/usr/bin/env bash

. 0_env.sh

set -o xtrace

mkdir --mode 777 -p "$ANDROID_HOME"
cd "$ANDROID_HOME"
curl -o sdk.zip $SDK_URL
unzip -qq sdk.zip > /dev/null 2>&1
rm sdk.zip
yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
