#!/usr/bin/env bash

. 0_env.sh
set -o xtrace

$SDK_MANAGER --update > /dev/null 2>&1
$SDK_MANAGER "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_VERSION}" "platform-tools" > /dev/null 2>&1
