#!/usr/bin/env bash

ORIG=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -e $DIR/../lib/libcpprest*.so ] ; then
    echo "cpprest has alredy been built."
    /usr/bin/env bash "$DIR/installCppRESTsdk.sh"
    exit 0
else
    echo "building cpprestsdk (you sould only have to do this once, internet access is required)"
fi


if [[ "$RUN" = false ]] ; then
	echo "Exiting"
	exit 1
fi

declare -a requirements=("g++" "libssl-dev")
for req in "${requirements[@]}" ; do
	if ! dpkg -s "$req" &>/dev/null
	then
		echo "! Missing $req."
		RUN=false
	else
		echo ". Found $req."
	fi
done


git submodule init
git submodule update


mkdir -p "$DIR/build.release"
cd "$DIR/build.release"
echo '*' > .gitignore
CXX=g++ cmake ../cpprestsdk/Release #-DBOOST_ROOT=$DIR/boost_1_54_0 #-DCMAKE_BUILD_TYPE=Release 
make

cp -v Binaries/lib*.so* "$DIR/../lib/"
rm "$DIR/../lib/libcpprest.so"
ln -sv libcpprest.so.2.8 "$DIR/../lib/libcpprest.so"

# Now install it

cd "$ORIG"
