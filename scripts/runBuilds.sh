#!/usr/bin/env bash

# runs build for a package that has a lib/main.dart
runBuild () {
  cd $1;
  #if grep flutter pubspec.yaml > /dev/null 2>&1; then
  if [ -f "lib/main.dart" ]; then
    echo "running build in $1"
    # check if build_runner needs to be run
    # todo: fix build in ./example/built_redux
    if grep build_runner pubspec.yaml > /dev/null  && [ "$1" != "./example/built_redux" ]; then
      flutter packages get
      flutter packages pub run build_runner build --delete-conflicting-outputs
    fi
    flutter build apk
  fi
}

export -f runBuild

# expects to find most packages at second directory level
find . -maxdepth 2 -type d -exec bash -c 'runBuild "$0"' {} \;
# find exits with 0
