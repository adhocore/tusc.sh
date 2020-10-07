# adhocore/tusc.sh

[![Latest Version](https://img.shields.io/github/release/adhocore/tusc.sh.svg?style=flat-square)](https://github.com/adhocore/tusc.sh/releases)
[![Travis Build](https://img.shields.io/travis/com/adhocore/tusc.sh/master.svg?style=flat-square)](https://travis-ci.com/adhocore/tusc.sh?branch=master)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE)

`tusc` is [tus 1.0.0](https://tus.io) client protocol implementation for bash.

`tusc` lets you upload big files to servers supporting tus protocol right from your terminal.

If anything goes wrong, you can rerun the command to resume upload from where it was left off.

> **Fun Fact**: Git LFS also supports tus.io protocol.

## Installation

```sh
# Requirements:
# jq
sudo apt install jq -y

curl -sSLo ~/tusc https://github.com/adhocore/tusc.sh/releases/latest/download/tusc
# for global binary
chmod +x ~/tusc && sudo ln -s ~/tusc /usr/local/bin/tusc
# OR, for user binary
chmod +x ~/tusc && mv ~/tusc ~/.local/bin/tusc
```

### System Requirements

- `base64`
- `curl`
- `dd`
- `grep`
- `mktemp`
- `readlink`, `realpath`
- `sha1sum`, `sha256sum`, `seq`, `sleep`

> Donot worry, in a typical UNIX flavored system these are likely to be there already.


## Usage and Examples
```
  tusc v0.5.0 | (c) Jitendra Adhikari
  tusc is bash implementation of tus-client (https://tus.io).

  Usage:
    tusc <--options> -- [curl args]
    tusc <host> <file> [algo] -- [curl args]

  Options:
    -a --algo      The algorigthm for key &/or checksum.
                   (Eg: sha1, sha256)
    -b --base-path The tus-server base path (Default: '/files/').
    -c --creds     File with credentials; user and pass in shell syntax:
                     USER="my_user"
                     PASS="my_pass"
    -C --no-color  Donot color the output (Useful for parsing output).
    -f --file      The file to upload.
    -h --help      Show help information and usage.
    -H --host      The tus-server host where file is uploaded.
    -L --locate    Locate the uploaded file in tus-server.
    -S --no-spin   Donot show the spinner (Useful for parsing output).
    -u --update    Update tusc to latest version.
       --version   Print the current tusc version.

  Examples:
    tusc --help                           # shows this help
    tusc --update                         # updates itself
    tusc --version                        # prints current version of itself
    tusc    0:1080    ww.mp4              # uploads ww.mp4 to http://0.0.0.0:1080/files/
    tusc -H 0:1080 -f ww.mp4              # same as above
    tusc -H 0:1080 -f ww.mp4 -- -Lv       # same as above plus sends -Lv to curl command
    tusc -H 0:1080 -f ww.mp4 -a sha256    # same as above but uses sha256 algo for key/checksum
```

If you want to parse the output of `tusc`, pass in `-C` (no color) and `-S` (no spin) flags. Eg:
```sh
# Locate the URL of a file and download it
wget $(tusc -H 0:1080 -f ww.mp4 -L -S -C | cut -c 6-999) -O ww.mp4.1
```

### Authentication

If your tusd server requires special header or token for auth, just pass in `[curl args]`:
```sh
tusc -H 0:1080 -f ww.mp4 -b /store/ -- -H 'Authorization: Bearer <token>'
```

In fact you can pass in anything after `--` as extra curl parameter.

### Preview
See `tusc` in action with debug mode where the upload is aborted frequently with `Ctrl+C` interrupt.

[![Screen Preview](https://imgur.com/SN4lE3o.gif "tusc in action")](https://github.com/adhocore/tusc.sh)

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


## Trying Out
To get hands on in local machine, you can install [tusd](https://github.com/tus/tusd#download-pre-builts-binaries-recommended) server.

Then,
```sh
# run tusd server (http://0.0.0.0:1080)
tusd -dir ~/.tusd-data > /dev/null 2>&1 &

# start uploading large files
DEBUG=1 tusc --host 0:1080 --file /full/path/to/large/file
```

While upload is in progress, you can force abort it using `Ctrl+C`.

> Then resume upload again:
```sh
DEBUG=1 tusc --host 0:1080 --file /full/path/to/large/file
```

It should start from where it last stopped.

> You can check the uploaded files like so:
```sh
ls -al ~/.tusd-data
```


### Contributors

- [adhocore](https://github.com/adhocore) - **Lead Developer**
- [tonk](https://github.com/tonk) - **Credential support**
- Wouter van Hilst - **Chunked upload**
