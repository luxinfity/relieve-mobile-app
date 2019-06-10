# Relieve ID Mobile App

[![Codemagic build status](https://api.codemagic.io/apps/5c5fc37d87300500151053e5/5c5fc37d87300500151053e4/status_badge.svg)](https://codemagic.io/apps/5c5fc37d87300500151053e5/5c5fc37d87300500151053e4/latest_build)

Relieve Mobile App, Written in Flutter, for android and ios.

## Run
1. before any run to replace `API KEY` flags. run script

    ```
    ./setAPIkey.sh
    ```
2. Select environtment to run
    
    Debug: 
    ```
    flutter run
    ```
   
    Production: 
    ```
    flutter run --release -t lib/main_production.dart

## Build
1. before any build to replace `API KEY` flags. run script

    ```
    ./setAPIkey.sh
    ```
2. Select environtment to run
    
    Debug: 
    ```
    flutter build ios
    or
    flutter build apk
    ```
   
    Production: 
    ```
    flutter build ios --release -t lib/main_production.dart
    or
    flutter build apk --release -t lib/main_production.dart
    ```

## Secret API Key
Please contact admin to get `unloadAPIkey.sh` file

## Known Issue
- to test map, don't enable --enable-software-rendering
