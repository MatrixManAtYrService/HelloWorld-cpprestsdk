Linux:

Be sure the following packages are installed before you run ./buildCppRESTsdk.sh
the compiled libraries will be places in {ProjectRoot}/lib/

    g++-4.8 libssl-dev

Windows:

The winBuildCppRESTsdk.sh script will fetch cppRESTsdk's dependencies (which may take a while).  It will then call buildCppRESTsdk.bat (which calls msbuild) and then copy the libraries to {ProjectRoot}/lib/
