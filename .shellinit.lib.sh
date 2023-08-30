#!/bin/bash

if [ -e /opt/homebrew/bin/brew ]; then
    BREW_PREFIX=/opt/homebrew
elif [ -e /usr/local/bin/brew ]; then
    BREW_PREFIX=/usr/local
fi

if [ -e ${BREW_PREFIX}/opt/chruby/share/chruby/chruby.sh ]; then
    . ${BREW_PREFIX}/opt/chruby/share/chruby/chruby.sh
    . ${BREW_PREFIX}/opt/chruby/share/chruby/auto.sh
    if [ "`chruby`" != "ruby-3.1.3" ]; then
        chruby 3.1.3
    fi
else
    echo "chruby not found"
fi
RUBY_VERSION="`ruby -e "puts RUBY_VERSION"`"
