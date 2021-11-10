#!/usr/bin/env bash

ASDF_PLUGINS=(python nodejs);
TOOL_VERSIONS="$HOME/.tool-versions";
VERSION_PATTERN="^[0-9]+\.[0-9]+\.[0-9]+$";

if [[ -f $TOOL_VERSIONS ]]; then
    echo "$TOOL_VERSIONS already exists!  Skipping ASDF setup.";
fi

for plugin in $ASDF_PLUGINS; do
    asdf plugin add $plugin;
    latest_version=$( \
        asdf list all $plugin \
        | grep -E "$VERSION_PATTERN" \
        | sort -V \
        | tail -1 \
    );

    echo "$plugin $latest_version" >> $TOOL_VERSIONS;
done

pushd $(dirname $TOOL_VERSIONS);
asdf install;
popd;
