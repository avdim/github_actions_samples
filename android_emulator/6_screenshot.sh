#!/usr/bin/env bash

. 0_env.sh
set -o xtrace

sleep 60
#$ADB -e shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > /tmp/screen.png

$ADB -e shell screencap /sdcard/screen.png
$ADB -e pull /sdcard/screen.png

