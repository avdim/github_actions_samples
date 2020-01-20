#!/usr/bin/env bash

. 0_env.sh
set -o xtrace

yes | $SDK_MANAGER "system-images;android-${ANDROID_VERSION};google_apis;x86_64" #default
