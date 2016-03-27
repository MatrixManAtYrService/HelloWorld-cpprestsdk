#!/usr/bin/env bash

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

ORIG=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -L /usr/local/lib/libcpprest*.so ] ; then
    echo "cpprest is alredy been installed"
    exit 0
else
    if [ -f "$DIR/../../lib/libcpprest.so.2.8" ] ; then
        echo "installing cpprestsdk to /usr/local/lib"
        cp -v "$DIR/../../lib/libcpprest.so.2.8" "/usr/local/lib"
        cd "/usr/local/lib"
        ln -sv libcpprest.so.2.8 libcpprest.so
    else
        echo "$DIR/../../lib.libcpprest.so.2.8 not found, not installing"
    fi
    cd "/usr/local/lib"
fi

echo stuff

cd "$ORIG"
