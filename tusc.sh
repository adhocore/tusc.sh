#!/usr/bin/env bash
#
# TUS client protocol implementation for bash.
#
# Author:
#   Jitendra Adhikari <jiten.adhikary@gmail.com>
#
# Be sure to check readme doc at https://github.com/adhocore/bash-tus
#

# message helpers
line() { echo -e "\e[${3:-0};$2m$1\e[0m"; }
error() { line "$1" 31; if [[ ! ${2:-0} -eq 0 ]]; then exit $2; fi }
ok() { line "${1:-  Done}" 32; }
info() { line "$1" 33; }
comment() { line "$1" 30 1; }
