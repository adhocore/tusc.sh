# adhocore/tusc.sh

[![Latest Version](https://img.shields.io/github/release/adhocore/tusc.sh.svg?style=flat-square)](https://github.com/adhocore/tusc.sh/releases)
[![Travis Build](https://img.shields.io/travis/com/adhocore/tusc.sh/master.svg?style=flat-square)](https://travis-ci.com/adhocore/tusc.sh?branch=master)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE)

tusc is [TUS](https://tus.io) client protocol implementation for bash.

## Installation

```sh
# Requirements:
# jq
sudo apt install jq -y

curl -sSLo ~/tusc https://raw.githubusercontent.com/adhocore/tusc.sh/master/tusc.sh
chmod +x ~/tusc && sudo ln -s ~/tusc /usr/local/bin/tusc
```

## Usage and Examples

```
  tusc v0.0.1 | (c) Jitendra Adhikari
  tusc is bash implementation of tus-client (https://tus.io).
  Usage:
    tusc <--options>
    tusc <host> <file> [algo]
  Options:
    -a --algo      The algorigthm for key &/or checksum.
                   (Eg: sha1, sha256)
    -f --file      The file to upload.
    -h --help      Show help information and usage.
    -H --host      The tus-server host where file is uploaded.
  Examples:
    tusc version                 # prints current version of itself
    tusc --help                  # shows this help
    tusc 0:1080 ww.mp4           # uploads ww.mp4 to http://0.0.0.0:1080
    tusc -f ww.mp4 -H 0:1080     # same as above
```

### Debugging

To print the debugging information pass in `DEBUG=1` env like so:
```sh
DEBUG=1 tusc 0:1080 ww.mp4
```

To print the lines of script as they are executed, create a debug file:
```sh
touch ~/.tus.dbg
```

To revert the above step, just remove the debug file:
```sh
rm ~/.tus.dbg
```
