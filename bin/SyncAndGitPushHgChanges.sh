#! /bin/sh

repo="$1"
if [ ! "$repo" ] ; then
	repo=.
fi

if [ ! -d "$repo" ] ; then
	echo "'$repo' does not appear to be a directory."
	exit 1
fi

cd "$repo"

hg status > /dev/null 2>&1

if [ $? -ne 0 ] ; then
	echo "'$repo' does not appear to be an hg repository."
	exit 1
fi

name=$(basename $(pwd))
echo "Repository is $name"

hg summary | grep -q 'commit: (clean)'

if [ $? -ne 0 ] ; then
	echo "Uncommited changes!"
	exit 1
fi

hg pull -u

if [ $? -ne 0 ] ; then
	echo "Failed to pull changes (could be unsychronized local changes)"
	exit 1
fi

echo

push="git+ssh://git@github.com:iondune/${name}.git"

hg bookmark -r default master
hg outgoing "$push"

if [ $? -ne 0 ] ; then
	exit 0
fi

hg push "$push"

if [ "$?" -ne 0 ] ; then
	echo "Something bad has happened!"
fi
