# simple_chopper_example

A new Flutter project with Firebase and stacked architecture

## Getting Started

- flutter pub clean
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