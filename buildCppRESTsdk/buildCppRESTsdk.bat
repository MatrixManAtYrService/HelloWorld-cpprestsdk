@echo off
REM this script builds cpprestsdk


REM set up visual studio command environment
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86_amd64

cd "cpprestsdk"
msbuild cpprestsdk140.sln /p:Configuration=Debug /p:Platform=Win32 /p:UseEnv=true

