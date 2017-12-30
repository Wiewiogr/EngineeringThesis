#!/bin/bash

echo "dir/prefixed"
echo "dir/with"
echo "user/$1"
echo "file/$(echo $2 | base64 --decode )"
echo "file/raw/$2"
echo "commit/$3"

