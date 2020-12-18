#!/usr/bin/env bash
#
# TUS client 1.0.0 protocol implementation for bash.
#
# Author:
#   Jitendra Adhikari <jiten.adhikary@gmail.com>
#
# Be sure to check readme doc at https://github.com/adhocore/tusc.sh
#

if [[ -f ~/.tus.dbg ]]; then set -ex; else set -e; fi

FULL=$(readlink -f $0) TUSC=$(basename $0) SPINID=0 CURLARGS=

declare -A HEADERS    # assoc headers of last request
declare ISOK=0        # is last request ok?

# message helpers
line() {
  [[ $NOCOLOR ]] && echo -e "$1" || echo -e "\e[${3:-0};$2m$1\e[0m"
  [[ "$4" == "" ]] || exit $4
}
error() { line "$1" 31 0 $2; }
ok() { line "${1:-  Done}" 32 0 $2; }
info() { line "$1" 33 0 $2; }
comment() { line "$1" 30 1 $2; }

# show version
version() { echo v0.8.0; }

# update tusc
update()
{
  NEWVER=`curl -sSL https://raw.githubusercontent.com/adhocore/tusc.sh/master/VERSION`
  [[ "v$NEWVER" == "$(version)" ]] && ok "Already latest version" 0

  info "Updating $TUSC ..."
  curl -sSLo ${FULL} https://raw.githubusercontent.com/adhocore/tusc.sh/master/tusc.sh
  ok "  Done [${NEWVER}]"
}

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
    $(info "-b --base-path") $(comment "The tus-server base path (Default: '/files/').")
    $(info "-c --creds")     $(comment "File with credentials; user and pass in shell syntax:")
                     $(line 'USER="my_user"' 36)
                     $(line 'PASS="my_pass"' 36)
    $(info "-C --no-color")  $(comment "Donot color the output (Useful for parsing output).")
    $(info "-f --file")      $(comment "The file to upload.")
    $(info "-h --help")      $(comment "Show help information and usage.")
    $(info "-H --host")      $(comment "The tus-server host where file is uploaded.")
    $(info "-L --locate")    $(comment "Locate the uploaded file in tus-server.")
    $(info "-S --no-spin")   $(comment "Donot show the spinner (Useful for parsing output).")
    $(info "-u --update")    $(comment "Update tusc to latest version.")
    $(info "   --version")   $(comment "Print the current tusc version.")

  $(ok Examples:)
    $TUSC --help                           # shows this help
    $TUSC --update                         # updates itself
    $TUSC --version                        # prints current version of itself
    $TUSC    0:1080    ww.mp4              # uploads ww.mp4 to http://0.0.0.0:1080/files/
    $TUSC -H 0:1080 -f ww.mp4              # same as above
    $TUSC -H 0:1080 -f ww.mp4 -a sha256    # same as above but uses sha256 algo for key/checksum
    $TUSC -H 0:1080 -f ww.mp4 -b /store/   # uploads ww.mp4 to http://0.0.0.0:1080/store/
USAGE
}

# get/set tus config
tus-config() # $1 = key, $2 = value
{
  TUSFILE=`realpath ~/.tus.json`
  [[ -f $TUSFILE ]] || echo '{}' > $TUSFILE
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
  dd bs=32M skip="$1" count="$2" iflag=skip_bytes ${3:+if="$3"} ${3:+of="$3.part"} > /dev/null 2>&1

  echo `realpath $3.part`
}

# http request
request()
{
  echo > $HEADER
  [[ $CREDS ]] && USERPASS="--basic --user '$USER:$PASS' "
  [[ $DEBUG ]] && comment "> curl ${USERPASS//:$PASS/}-sSLD $HEADER -H 'Tus-Resumable: 1.0.0' $1"
  BODY=$(bash -c "curl $USERPASS-sSLD $HEADER -H 'Tus-Resumable: 1.0.0' $CURLARGS $1") HEADERS=()

  while IFS=':' read key value; do
    if [[ "${key:0:5}" == "HTTP/" ]]; then
      value=$(echo "$key" | grep -Eo '[0-9]{3}') key=Status
    fi
    value="${value/ /}"  HEADERS[$key]="${value%$'\r'}"
  done < <(cat "$HEADER")

  if [[ "${HEADERS[Status]}" == "20"* ]]; then ISOK=1; else ISOK=0; fi
  if [[ $ISOK -eq 0 ]] && [[ "$1" != *"--head"* ]]; then error "$BODY" 1; fi
}

# show spinner and mark its pid
spinner()
{
  [[ $NOSPIN ]] && return 0
  do-spin &
  SPINID=$!
  disown
}

# do spin (credits: https://www.shellscript.sh/tips/spinner/)
do-spin()
{
  local chars="+/|\\-+/|\\-"
  while :; do
    for i in `seq 0 9`; do
      echo -n "${chars:$i:1}" && echo -en "\010" && sleep 0.1
    done
  done
}

no-spinner()
{
  [[ $NOSPIN ]] && return 0
  local PID=$SPINID
  SPINID=0
  [[ $PID -eq 0 ]] || kill $PID 2> /dev/null
}

# exit handler
on-exit()
{
  no-spinner
  rm -f $FILE.part $HEADER0 $HEADER
  [[ $OFFSET ]] || return 0

  OFFSET=${HEADERS[Upload-Offset]:-0}  LEFTOVER=$((SIZE - OFFSET))
  if [[ $LEFTOVER -eq 0 ]]; then
    ok "✔ Uploaded successfully!"
  else
    error "✖ Unfinished upload, please rerun the command to resume." 1
  fi
  info "URL: $TUSURL"
}

# argv parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
    -a | --algo) SUMALGO="$2"; shift 2 ;;
    -b | --base-path) BASEPATH="$2"; shift 2 ;;
    -c | --creds) CREDS="$2"; shift 2 ;;
    -C | --no-color) NOCOLOR=1; shift ;;
    -f | --file) FILE="$2"; shift 2 ;;
    -h | --help | help) usage $1; exit 0 ;;
    -H | --host) HOST="$2"; shift 2 ;;
    -L | --locate) LOCATE=1; shift ;;
    -S | --no-spin) NOSPIN=1; shift ;;
    -u | --update) update; exit 0 ;;
         --version | version) version; exit 0 ;;
    --) shift; CURLARGS=$@; break ;; 
    *) if [[ $HOST ]]; then
        if [[ $FILE ]]; then SUMALGO="${SUMALGO:-$1}"; else FILE="$1"; fi
      else HOST=$1; fi
      shift ;;
  esac
done

trap on-exit EXIT

[[ $CREDS ]] && { [[ -f $CREDS ]] && source $CREDS && [[ $PASS ]] || error "--creds file couldn't be loaded" 1; }
[[ $HOST ]] || [[ $LOCATE ]] || error "--host required" 1
[[ $FILE ]] || error "--file required" 1
[[ -f $FILE ]] || error "--file doesn't exist" 1

SUMALGO=${SUMALGO:-sha1}
[[ $SUMALGO == "sha"* ]] || error "--algo '$SUMALGO' not supported" 1

FILE=`realpath $FILE`  NAME=`basename $FILE`  SIZE=`stat -c %s $FILE`  MTIME=`stat -c %Y $FILE`
HEADER=`mktemp -t tus.XXXXXXXXXX`

# calc &/or cache key and checksum
KEY=`tus-config ".[\"$FILE:$MTIME\"].$SUMALGO?"`
[[ "null" == "$KEY" ]] && [[ $DEBUG ]] && comment "> ${SUMALGO}sum $FILE"
[[ "null" == "$KEY" ]] && spinner && read -r KEY _ <<< `${SUMALGO}sum $FILE` && no-spinner
tus-config ".[\"$FILE:$MTIME\"].$SUMALGO" "$KEY"
CHKSUM="$SUMALGO $(echo -n $KEY | base64 -w 0)"

[[ $DEBUG ]] && info "HOST  : $HOST\nHEADER: $HEADER\nFILE  : $NAME\nSIZE  : $SIZE\nKEY   : $KEY\nCHKSUM: $CHKSUM"

# head request
TUSURL=`tus-config ".[\"$KEY\"].location?"`
[[ $LOCATE ]] && info "URL: $TUSURL" && [[ $TUSURL != "null" ]]; [[ $LOCATE ]] && exit $?
[[ $TUSURL ]] && [[ "null" != "$TUSURL" ]] && request "--head $TUSURL"

if [[ "null" != "$TUSURL" ]] && [[ $ISOK -eq 1 ]]; then
  OFFSET=${HEADERS[Upload-Offset]} LEFTOVER=$((SIZE - OFFSET))
  [[ $LEFTOVER -eq 0 ]] && exit 0
  [[ $DEBUG ]] && comment "> filepart $OFFSET $LEFTOVER $FILE"
  spinner && FILEPART=`filepart $OFFSET $LEFTOVER $FILE` && no-spinner

# create request
else
  OFFSET=0 LEFTOVER=$SIZE FILEPART=$FILE
  META="filename $(echo -n $NAME | base64 -w 0)"
  [[ $CREDS ]] && META="$META,user $(echo -n $USER | base64 -w 0)"
  request "-H 'Upload-Length: $SIZE' \
    -H 'Upload-Key: $KEY' \
    -H 'Upload-Checksum: $CHKSUM' \
    -H 'Upload-Metadata: $META' \
    -X POST $HOST${BASEPATH:-/files/}"

  TUSURL=${HEADERS[Location]}
  [[ $TUSURL ]] || error "Tus server replied with empty location. Try changing --base-path param." 1
  [[ $TUSURL != *"://"* ]] && TUSURL=$HOST$TUSURL

  # save location config
  tus-config ".[\"$KEY\"].location" "$TUSURL"
fi

# patch request
request "-H 'Content-Type: application/offset+octet-stream' \
  -H 'Content-Length: $LEFTOVER' \
  -H 'Upload-Checksum: $CHKSUM' \
  -H 'Upload-Offset: $OFFSET' \
  -H 'Transfer-Encoding: chunked' \
  --upload-file '$FILEPART' \
  --request PATCH $TUSURL" &

# show spinner
spinner
HEADER0=$HEADER HEADER=`mktemp -t tus.XXXXXXXXXX`
while :; do
  [[ ${HEADERS[Upload-Offset]} -eq $SIZE ]] && exit
  request "--head $TUSURL" > /dev/null
  [[ ${HEADERS[Upload-Offset]} -eq $SIZE ]] || sleep 2
done
