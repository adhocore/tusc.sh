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

declare -A HEADERS    # assoc headers of last request
declare ISOK=0        # is last request ok?

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

# get/set tus config
tus-config()
{
  TUSFILE=`realpath ~/.tus.json`
  if [ ! -f $TUSFILE ]; then echo '{}' > $TUSFILE; fi
  TUSJSON=`cat $TUSFILE`

  if [[ $# -eq 0 ]]; then
    echo $TUSJSON
  elif [[ $# -eq 1 ]]; then
    echo $TUSJSON | jq -r "$1"
  else
    echo $TUSJSON | jq "$1=\"$2\"" > $TUSFILE
  fi
}

# create a part of file
filepart() # $1 = start_byte, $2 = byte_length, $3 = file
{
  dd bs=32M skip="$1" count="$2" iflag=skip_bytes ${3:+if="$3"} of="$3.part" > /dev/null 2>&1

  echo `realpath $3.part`
}

# http request
request()
{
  echo > $HFILE
  [[ $DEBUG -eq 1 ]] && comment "> curl -sSLD $HFILE -H 'Tus-Resumable: 1.0.0' $1"
  BODY=$(bash -c "curl -sSLD $HFILE -H 'Tus-Resumable: 1.0.0' $1")
  HEADERS=()

  while IFS=':' read key value; do
    if [[ "${key:0:5}" == "HTTP/" ]]; then
      value=$(echo "$key" | grep -Eo '[0-9]{3}') key=Status
    fi
    value="${value/ /}"
    HEADERS[$key]="${value%$'\r'}"
  done < <(cat "$HFILE")

  if [[ "${HEADERS[Status]}" == "20"* ]]; then ISOK=1; else ISOK=0; fi

  if [[ $ISOK -eq 0 ]] && [[ "$1" != *"--head"* ]]; then error "$BODY" 1; fi
}

# argv parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
    -a | --algo) SUMALGO="$2"sum; shift 2 ;;
    -b | --base-path) BASEPATH="$2"; shift 2 ;;
    -f | --file) FILE="$2"; shift 2 ;;
    -h | --help | help) usage $1 ;;
    -H | --host) HOST="$2"; shift 2 ;;
    version) version; exit 0 ;;
    *) if [[ $HOST ]]; then
        if [[ $FILE ]]; then SUMALGO="${SUMALGO:-$1}sum"; else FILE="$1"; fi
      else HOST=$1; fi
      shift ;;
  esac
done

[[ $HOST ]] || error "--host required" 1
[[ $FILE ]] || error "--file required" 1
[[ -f $FILE ]] || error "--file doesnt exist" 1

SUMALGO=${SUMALGO:-sha1}
[[ $SUMALGO == "sha"* ]] || error "--algo not supported" 1

FILE=`realpath $FILE` NAME=`basename $FILE` SIZE=`stat -c %s $FILE` HFILE=`mktemp -t tus.XXXXXXXXXX`

[[ $DEBUG -eq 1 ]] && info "Host: $HOST | Header: $HFILE\nFile: $NAME | Size: $SIZE"
[[ $DEBUG -eq 1 ]] && comment "Calculating key ..."
KEY=`${SUMALGO}sum $FILE | awk '{ print $1 }'`

# head request
TUSURL=`tus-config ".[\"$KEY\"].location?"`
[[ "null" != "$TUSURL" ]] && request "--head $TUSURL"

# calc checksum
CHKSUM="$SUMALGO $(echo -n $KEY | base64 -w 0)"

if [[ "null" != "$TUSURL" ]] && [[ $ISOK -eq 1 ]]; then
  OFFSET=${HEADERS[Upload-Offset]} LEFTOVER=$((SIZE - OFFSET))
  [[ $LEFTOVER -eq 0 ]] && ok "Already uploaded successfully!" && exit 0
  [[ $DEBUG -eq 1 ]] && comment "> filepart $OFFSET $LEFTOVER $FILE"
  FILEPART=`filepart $OFFSET $LEFTOVER $FILE`
# create request
else
  OFFSET=0 LEFTOVER=$SIZE FILEPART=$FILE
  request "-H 'Upload-Length: $SIZE' \
    -H 'Upload-Key: $KEY' \
    -H 'Upload-Checksum: $CHKSUM' \
    -H 'Upload-Metadata: filename $(echo -n $NAME | base64 -w 0)' \
    -X POST $HOST${BASEPATH:-/files/}"

  TUSURL=${HEADERS[Location]}
fi
