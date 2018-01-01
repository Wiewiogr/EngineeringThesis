#!/bin/bash

to_watch=$1
inotifywait -e modify,create,delete,moved_to,moved_from -m ${to_watch} | 
while read -r directory event filename; do 
	abs_file_path=${to_watch}/${filename}
	git -C ${to_watch} add -A &&
	git -C ${to_watch} commit -m "${filename} $(date +%s) ${event}" &&
	git -C ${to_watch} push
done
