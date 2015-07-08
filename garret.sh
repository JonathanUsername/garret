#!/bin/bash
#
#
#
#  ██████╗  █████╗ ██████╗ ██████╗ ███████╗████████╗
# ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝
# ██║ ████╗███████║██████╔╝██████╔╝█████╗     ██║   
# ██║ ╚═██║██╔══██║██╔══██╗██╔══██╗██╔══╝     ██║   
# ╚███████║██║  ██║██║  ██║██║  ██║███████╗   ██║   
#  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   
#
#                                                       /\
# This program simplifies opening multiple             /__\ 
# programs to work on a project.                      / ___\                                                  
# It's much like Grunt, but simpler, uses bash,      /   ___\                                                  
# and pipes everything to xargs                     /     ___\                                                  
# so that it can start up with the sweet,          /;.........\                                                  
# sweet power of parallel processing.              |;         |
#                                                  \\:        | 
#                                                   \\:      / 
#  And this is some random ASCII art.                ||:    |
#                                                    ||:    |
#  Because.                                          ||:    |
#  Just because.                                     ||:    |       \ /
#                                                    ||:    |            /`\
#                                                    ||:    |
#                                                    ||:    |
#               __                            ___    ||_    |
#      ____--``    '--``__            __ ----`    ``--- ____|_            
# -`--`                   `---__  --`'                        `_____-`'


# Path to your code directory
P="/home/jon/Code/"

# Update the autocomplete when calling "garret" with no target
IFS=$'\n'
COMPLETES=$(ls -d "$P"*/ | rev | awk -F"/" '{ print $2 }' | rev)
complete -W "$COMPLETES" garret
if [[ $# -eq 0 ]]; then
	echo "Updated autocomplete."
	exit 0
fi

# Open Garretfile
p="$P""$1/"
GF="$p""Garretfile"
APPS=$(cat $GF 2>/dev/null)
if [ $? == 1 ]; then
	ls "$p"
	echo "No Garretfile found in $p"
else
	echo "Found Garretfile, starting.."
	cd "$p"
	pwd

	# This can be replaced with "cat $GF | parallel -P 8 -n 1",
	# which is neater, but you'll need to download GNU Parallel
	cat $GF | xargs -P 8 -I HERE bash -c HERE &

	trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

	# Now wait, so that you can quit everything with a single Ctrl+C
	while :			
	do
	    sleep 60	
	done
fi




