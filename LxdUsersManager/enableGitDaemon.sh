#!/bin/bash

git daemon --export-all --enable=receive-pack --reuseaddr --informative-errors --verbose --base-path=$1
