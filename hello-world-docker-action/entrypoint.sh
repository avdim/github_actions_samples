#!/bin/sh -l

echo "Hello, dear $1"
time=$(date)
echo ::set-output name=time::$time
