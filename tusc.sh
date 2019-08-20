#!/usr/bin/env bash
#
# TUS client protocol implementation for bash.
#
# Author:
#   Jitendra Adhikari <jiten.adhikary@gmail.com>
#
# Be sure to check readme doc at https://github.com/adhocore/bash-tus
#

FULL=`readlink -f $0` # fullpath
TUSC=`basename $0`    # name

# message helpers
line() { echo -e "\e[${3:-0};$2m$1\e[0m"; }
error() { line "$1" 31; if [[ ! ${2:-0} -eq 0 ]]; then exit $2; fi }
ok() { line "${1:-  Done}" 32; }
info() { line "$1" 33; }
comment() { line "$1" 30 1; }

# show version
version() { echo v0.0.1; }

# show usage
usage()
{
  cat << USAGE
  $TUSC $(info `version`) | $(ok "(c) Jitendra Adhikari")
  $TUSC is bash implementation of tus-client (https://tus.io).
  $(ok Usage:)
    $TUSC <--options>
    $TUSC <host> <file> [algo]
  $(ok Options:)
    $(info "-a --algo")      $(comment "The algorigthm for key &/or checksum.")
                   $(comment "(Eg: sha1, sha256)")
    $(info "-f --file")      $(comment "The file to upload.")
    $(info "-h --help")      $(comment "Show help information and usage.")
    $(info "-H --host")      $(comment "The tus-server host where file is uploaded.")
  $(ok Examples:)
    $TUSC
    $TUSC version             $(comment "# prints current version of itself")
    $TUSC --help              $(comment "# shows this help")
USAGE
  exit 0
}
