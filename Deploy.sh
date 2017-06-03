#! /bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

files=$(find ./config -name '*.symlink')
for file in $files ; do
    linkTarget="${file#./config/}"
    linkSource="$HOME/.${linkTarget%.*}"
    linkTarget="${dir}/config/${linkTarget}"
    ln -sf "$linkTarget" "$linkSource"
done

bashLocal="$HOME/.bash_local"
colorsFile="${dir}/colors/$( hostname )"

if [ ! -f "$bashLocal" -a -f "$colorsFile" ]; then
    cp "$colorsFile" "$bashLocal"
fi
