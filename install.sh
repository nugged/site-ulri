#!/bin/bash

brew install chruby ruby-install xz

SELFDIR="$(dirname $0)"
PROJECT="$1"
[ -z "$PROJECT" ] && { echo "Usage: $0 <project>"; exit 1; }

. "${SELFDIR}/.shellinit.lib.sh"
cd "$SELFDIR/$PROJECT" || { echo "Failed to cd to ${SELFDIR}/$PROJECT"; exit 1; }

if [ "$RUBY_VERSION" != "3.1.3" ]; then
    ruby-install ruby 3.1.3
    chruby 3.1.3
fi
gem install jekyll

bundle install
