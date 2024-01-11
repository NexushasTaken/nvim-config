#!/bin/bash
# vi: ft=sh
CONFIG=$(dirname $(realpath $BASH_SOURCE))
ln -vsf $CONFIG/scripts/vi-gd $HOME/.local/bin
