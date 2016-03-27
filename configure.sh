#!/usr/bin/env bash

# create build directory if it doesn't exist
mkdir -p build && 
cd build && 

# put a .gitignore file there so user-specific files don't get checked in accidentally
echo "*" > .gitignore && 
echo "!.gitignore" >> .gitignore && 

# If you'd like to make persistent, configuration-specific, changes, consider putting those files in a new repository and then adding it as a subrepo.  That way, carting around environment-specific files is optional. Feel free to do this for convenience, but keep in mind that mission-critical changes should go through CMakeLists.txt so that we don't break platform-independence.

# -g (GNU Make)
if [[ $1 == -*[gG]* ]] ; then
    # build cpprestsdk, if it doesn't already exist
    cd ../buildCppRESTsdk/
    /usr/bin/env bash linBuildCppRESTsdk.sh
    cd ../build/

    # The IDE's specify the build type internally, but it would seem that Make wants it explicitly
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug

# -v (Visual Studio 2015)
elif [[ $1 == -*[vV]* ]] ; then
    # build cpprestsdk, if it doesn't already exist
    cd ../buildCppRESTsdk/
    /usr/bin/env bash winBuildCppRESTsdk.sh
    cd ../build/

    # run cmake
    echo "configuring ./build/ for Visual Studio"
    cmake .. -G "Visual Studio 14 2015"

    mkdir -p Debug/
    cp -v ../lib/cpprest*.dll Debug/
    cp -v ../lib/cpprest*.pdb Debug/

# -c (eClipse)
# '-e' is interpreted by bash, so we can't use it here
elif [[ $1 == -*[cC]* ]] ; then
    PROJNAME=$(pwd | sed 's#.*/\([^/]*\)/[^/]*$#\1#')
    BUILDDIR="../../eclipseWorkspace/$PROJNAME"

    echo "Eclipse requires that the build directory be a sibling, not a child, of the project root.  Creating $BUILDDIR" | tee README.txt
    mkdir -p $BUILDDIR
    cd $BUILDDIR
    cmake "../../$PROJNAME" -G "Eclipse CDT4 - Unix Makefiles" -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE -DCMAKE_ECLIPSE_VERSION=4.5.1
    cd "../../$PROJNAME/build/"

# anything else
else
    echo "Generates a build configuration using CMake and puts it in ./build"
    echo "These project files are generated--so changes to them might get clobbered."
    echo ""
    echo "If you need to make a persistent change, consider modifying CMakeLists.txt"
    echo "That way, your change will propagate into everybody's configuration--not just yours."
    echo ""
    echo "Usage: configure [OPTION]"
    echo ""
    echo  "<none>                   Display this message"
    echo  "-g                       CRun cmake with no flags, puts Makefile in ./build"
    echo  "-v                       Configure build directory for Visual Studio 2015 (Win64)"
    echo  "-c                       Configure build directory for Eclipse" 

fi

# leave a breadcrumb so reconfigure.sh can recreate the right environment
echo $1 > .breadcrumb

# return to original directory
cd ..
