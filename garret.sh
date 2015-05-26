#!/bin/bash

P="/home/jon/Code/"
CMD=$1

# reset the autocomplete
IFS=$'\n'
COMPLETES=$(ls -d "$P" | rev | awk -F"/" '{ print $2 }' | rev)
complete -W "$COMPLETES" garret

# open Garretfile
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

	cat $GF | xargs -P 8 -I HERE bash -c HERE &

	trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

	while :			# This is the same as "while true".
	do
		echo "sleeping now."
	    sleep 60	# This script is not really doing anything.
	done
fi




