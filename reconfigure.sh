#!/usr/bin/env bash

if [ -f ./build/.breadcrumb ] ; then
    flag=`cat  ./build/.breadcrumb`
    if [ ! -z "$flag" ]; then
        if [[ $flag == -*[cC]* ]] ; then
            PROJNAME=$(pwd | sed 's#.*/\([^/]*\)$#\1#')
            BUILDDIR="../eclipseWorkspace/$PROJNAME"
            rm -rvf "$BUILDDIR" 
        else
            rm -rvf ./build/
        fi
        ./configure.sh "$flag"
    else
        echo "Unable to read breadcrumb, consider running ./configure.sh"
    fi
else
        echo "No breadcrumb found in ./build/"
        echo "Unable to determine how to recreate contents"
        echo "Consider running ./configure.sh first"
fi
