#!/usr/bin/env bash

ORIG=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -e $DIR/../lib/cpprest*.lib ] ; then
    echo "cpprest has alredy been built."
    exit 0
else
    echo "building cpprestsdk (you sould only have to do this once, internet access is required)"
fi

git submodule init
git submodule update

# fetch dependencies
./nuget.exe restore cpprestsdk/cpprestsdk140.sln

cd "$DIR"
# build it
cmd "/C buildCppRESTsdk.bat"
echo "Some errors above are ok (there's more to cpprestsdk than we're using)"
echo "Three files should get copied below:"

# move cpprest files to {project root}/lib
cd "$DIR"
find `pwd`/cpprestsdk/Binaries/ -name "cpprest*" | grep -E '[0-9]\.(dll|lib|exp|pdb)$' | xargs cp -v -t $DIR/../lib/

echo "If no files were copied, try opening cpprestsdk140.sln in visual studio and doing a \"rebuild solution\" and then rerunning this script"
# Also, consider changing buildCppRESTsdk.bat so that whatever happens in VS happens there too


cd "$ORIG"
