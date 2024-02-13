#!/bin/bash

main= #<path_to_home_directory>
dest= #<path_where_you_want_to_save_the_tar_file>
backup=$(tar -cf backup_"$(date +%Y-%m-%d)".tar --absolute-names

### During creating TAR archive, you can also add --exclude= command to skip some files/directories which you don't want to back up (like .gitignore file or .ssh directory).

backup_file="backup_$(date +'%Y-%m-%d').tar"
check_file="backup_*\.tar "
latest_file=$(ls -1t $dest/"$check_file" 2>/dev/null | head -1)

if [ -f "$dest/$check_file" ]; then 
		changes=$(find "$main" -type f -newer "$dest/$latest_file" | wc -l)
		if [ "$changes" -eq 0 ]; then
		mv "$dest/$latest_file" "$dest/$backup_file"
	
	else
		if ! tar -tvf "$dest/$latest_file" | grep -q -v '^d'; then
		    tar -uf "$dest/$latest_file" --absolute-names --exclude=.local --exclude=.config --exclude=.ssh --exclude=.cache --exclude=.git --exclude=.docker --exclude=.gitignore --exclude=.gitconfig --exclude=backupy "$main"
		    mv "$dest/$latest_file" "$dest/$backup_file"
		fi
		fi
	else
	if [ ! -f "$dest/$check_file" ]; then
	eval "$backup"
	mv "$backup_file" "$dest"	
	fi

fi
