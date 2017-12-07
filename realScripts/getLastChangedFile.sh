#!/bin/bash
path_to_repos=$1
user_name=$2
git -C ${path_to_repos}/${user_name}-wc pull -q
file_name=${path_to_repos}/${user_name}-wc/$(git -C ${path_to_repos}/${user_name}-wc diff-tree --no-commit-id --name-only HEAD -r | tail -n1)
echo ${file_name}
cat ${file_name}

