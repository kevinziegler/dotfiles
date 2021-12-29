#!/usr/bin/env bash

workdir=$(mktemp -d);
target="$HOME/Library/Spelling";
pushd "$workdir";

curl -o "hunspell-en-custom.zip" \
    'http://app.aspell.net/create?max_size=80&spelling=GBs&spelling=US&max_variant=0&diacritic=keep&special=hacker&special=roman-numerals&encoding=utf-8&format=inline&download=hunspell'
unzip "hunspell-en-custom.zip";

[ -d "target" ] || sudo mkdir "$target";
sudo chown root:wheel en-custom.*;
sudo mv en-custom.{aff,dic} "$target";

popd;

rm -rf "$workdir";
