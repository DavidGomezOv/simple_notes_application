# simple_notes_application

A simple notes application with stacked architecture, hive local database and clean architecture.

## Getting Started

- flutter clean
- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs

#Generate apk or appBundle
- flutter build apk --split-per-abi
- flutter build appbundle

#Generate obfuscated app
- project-root
- flutter build apk --obfuscate --split-debug-info=project-root

#Generate obfuscated app and split each version
- flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi --obfuscate --split-debug-info=project-root