#!/bin/sh -l

echo "Hello again $1"
time=$(date)
echo "::set-output name=time::$time"
