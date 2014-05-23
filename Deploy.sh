#! /bin/sh

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
for file in $(ls -1 $dir/config/) ; do
    ln -sf "$dir/config/$file" "$HOME/.$file"
done
