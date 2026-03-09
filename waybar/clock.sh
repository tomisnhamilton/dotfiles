#!/usr/bin/env bash

time=$(date +"%I:%M %p")
date_str=$(date +"%A, %B %d")

printf '{"text":"%s\\n%s"}\n' "$time" "$date_str"
