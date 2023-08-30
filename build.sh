#!/bin/bash
SELFDIR="$(dirname $0)"
PROJECT="$1"
[ -z "$PROJECT" ] && { echo "Usage: $0 <project>"; exit 1; }

. "${SELFDIR}/.shellinit.lib.sh"
[ -z "$RUBY_VERSION" ] && { echo "RUBY_VERSION is not set"; exit 1; }
cd "$SELFDIR/$PROJECT" || { echo "Failed to cd to ${SELFDIR}/$PROJECT"; exit 1; }

bundle exec jekyll build
