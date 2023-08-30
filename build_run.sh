#!/bin/bash
SELFDIR="$(dirname $0)"
PROJECT="$1"
[ -z "$PROJECT" ] && { echo "Usage: $0 <project>
Example for the best oneliner:
  cd ~/git/site-perlkohacon && { git checkout alpha && ./build_run.sh jekyll && rm -rf docs && git checkout main && git rebase alpha && ./build.sh; }"; exit 1 ; }

. "${SELFDIR}/.shellinit.lib.sh"
[ -z "$RUBY_VERSION" ] && { echo "RUBY_VERSION is not set"; exit 1; }
cd "$SELFDIR/$PROJECT" || { echo "Failed to cd to ${SELFDIR}/$PROJECT"; exit 1; }

# ( sleep 2; open http://localhost:4000; exit 0; ) &

bundle exec jekyll serve --livereload --open-url
# bundle exec jekyll build
# rm -rf "${SELFDIR}/docs"
