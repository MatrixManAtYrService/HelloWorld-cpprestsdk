# HelloWorld-cpprestsdk
Cross platform hello world using microsoft's cpprestsdk

Caution: this repo is unmaintained.  It was created as part of evaluating cpprestsdk, but we ultimately ended up using [Simple Web Server](https://github.com/eidheim/Simple-Web-Server) instead.

## Building the project

Requires Boost and CMake.  See [this page](https://github.com/MatrixManAtYrService/HelloWorld-sqlite/blob/master/dependency.md) for instructions.  Ignore the part about SQlite.

If you're on Windows, run `configure.sh -v` to build a visual studio solution.  This will invoke `./buildCppRESTsdk/winBuildCppRESTsdk.sh` which will gather dependencies and build the sdk in accordance with [microsoft's directions](https://github.com/Microsoft/cpprestsdk/wiki/How-to-build-for-Windows)

If you're on Linux, run `configure.sh -g` to set up for use with gnu make.  This will invoke `./buildCppRESTsdk/linBuildCppRESTsdk.sh` which will [do the same](https://github.com/Microsoft/cpprestsdk/wiki/How-to-build-for-Linux).

Once configure has been run, `./build` will contain the makefile or VS solution.

## Running It

First run `helloworldlistener`, which will sit and wait for a PUT request on `http://localhost:8080/RESTtest/`
Then, from the same machine but in a different terminal, run `helloworldspeaker`
If all goes well, that put request will go through and the listener will display its content, which should contain "Hello World!"
