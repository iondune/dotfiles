#! /bin/bash

if [ $# -eq 0 ] ; then
	echo "usage: WrapDate.sh <command to run>"
	exit 1
fi

(
echo "Running $1 at $(date) with arguments $@"
echo "--------------------------------------------------------------------------------"
exec "$@"
)
echo
echo
