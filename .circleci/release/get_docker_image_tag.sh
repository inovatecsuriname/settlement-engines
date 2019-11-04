#!/usr/bin/env bash

# Returns `latest` or crate version. If git_tag ($2) argument is given, it is considered as that the new version
# is published. If the tag is the form of semantic version like "ilp-node-0.4.1-beta.3", this script returns
# the version of crate like "0.4.1-beta.3" because tag names generated by `cargo release` look a bit redundant.
# If the tag is not one of semantic version, just returns the tag itself and the docker image will be tagged
# with the git tag.
# If no tag is given, it is considered as a `latest` (or possibly could be said `nightly`) build.
# This script requires `jq`

crate_name=$1 # currently not used, just make it consistent with `interledger-rs`
git_tag=$2

if [ -n "$git_tag" ]; then
    # If it is a tag of semantic version expression
    if [[ "$git_tag" =~ ^.*v([0-9]+)\.([0-9]+)\.([0-9]+)(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?(\+[0-9A-Za-z-]+)?$ ]] ; then
        cargo read-manifest --manifest-path Cargo.toml | jq -r .version
    else
        printf "$git_tag"
    fi
else
    printf "latest"
fi
