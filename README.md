# sanad

A new Flutter project.

## Localization

The app supports Arabic and English. Translation strings are in
`lib/l10n/arb/app_ar.arb` and `lib/l10n/arb/app_en.arb`; generated localization
classes are in `lib/l10n/generated/`.

After adding or changing translations, regenerate the localization classes with:

```sh
flutter gen-l10n
```

The app uses the device locale.

## Flutter SDK version

This project uses Flutter 3.50.0 stable with Dart 3.14.0, pinned in `.fvmrc`.
Install [FVM](https://fvm.app/) and run:

```sh
fvm install
fvm flutter pub get
fvm flutter test
```

GitHub Actions reads the same version from `.fvmrc` and runs the tests and web
build for pushes and pull requests targeting `develop`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
