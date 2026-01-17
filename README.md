# Movie App (Flutter)

The repository contains a Flutter movie app (source in `lib/`) that fetches data from The Movie Database (TMDB) and manages favorites/watchlist locally.

**Assumptions & Notes**
- Project root is the current folder containing `lib/`.
- The app's entrypoint is `lib/main.dart`.
- `lib/utils/constants.dart` currently contains a hard-coded `apiKey`. Replace it with your own TMDB API key or secure it before publishing.
- I did not find a `pubspec.yaml` in the workspace. If missing, follow the instructions below to create/restore it.

## Required tools
- Flutter SDK (stable) installed and on your PATH.
- Android SDK (for Android) and an emulator/device configured. On Windows, follow Flutter's Windows setup guide.
- Optional: VS Code or Android Studio for development.

## Suggested dependencies
The code references the following packages. Add them to your `pubspec.yaml` under `dependencies:` (versions are examples):

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
  shared_preferences: ^2.1.1
  flutter_local_notifications: ^12.0.0
  cached_network_image: ^3.2.3
```

## Setup (if you already have `pubspec.yaml`)
1. From the project root run:

```bash
flutter pub get
```

2. Launch an Android emulator or connect a device, then run:

```bash
flutter run
```

## Setup (if `pubspec.yaml` is missing)
1. From the project root run to initialize a default Flutter project files (this will create `pubspec.yaml` and other files):

```bash
flutter create .
```

2. Edit the generated `pubspec.yaml` and add the suggested dependencies above.
3. Run `flutter pub get`.
4. Run `flutter run`.

## Running (Windows / Android)
- Start an Android emulator or connect a device.
- From the project root: `flutter run`.
- To run from VS Code: open the project folder, select a device, press F5 or use the Run command.

## Configuration
- API: `lib/utils/constants.dart` contains `apiKey`, `baseUrl`, and image base URLs. Replace the `apiKey` with your TMDB key.
- Notifications: The app uses `flutter_local_notifications` and initializes it in `lib/services/notification_service.dart`.

## Common troubleshooting
- `flutter pub get` fails: ensure you are in the project root (where `pubspec.yaml` exists) and Flutter is installed.
- Missing packages: add them to `pubspec.yaml` and run `flutter pub get`.
- API responses failing: verify `apiKey` in `lib/utils/constants.dart` is valid and network access is allowed.

## Next suggestions (optional)
- Move sensitive values (like the API key) out of source control — use environment variables or a secure config.
- Add a `pubspec.yaml` (if missing) with proper `name`, `description`, and versions.

---
If you want, I can: (a) add a starter `pubspec.yaml` to the repo, (b) update `lib/utils/constants.dart` to load the API key from environment, or (c) run `flutter pub get` for you. Which should I do next?
