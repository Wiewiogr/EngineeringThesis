#!/usr/bin/env bash
to_watch=$1
inotifywait -e modify,create,delete -m ${to_watch} | 
while read -r directory event filename; do 
    abs_file_path=${to_watch}/${filename}
    git -C ${to_watch} add ${abs_file_path} &
    git -C ${to_watch} commit -m "$(date)" &
    git -C ${to_watch} push
    echo ${abs_file_path}
done
