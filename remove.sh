#!/bin/bash

dir= #here put the path to directory where your tar files are stored.
files=($(ls -t "$dir" | tail -n +2))

for file in "${files[@]}"; do
	if [[ -f "$dir/$file" ]]; then
		rm -f "$dir/$file"
	fi


done

exit 0
