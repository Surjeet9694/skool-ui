# Skool UI — School Management System Flutter App

Production-grade Flutter mobile application for the Skool School Management System.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter (latest stable) |
| Language | Dart 3.3+ |
| State Management | Riverpod 2 |
| Navigation | GoRouter |
| HTTP Client | Dio ||
| Secure Storage | flutter_secure_storage |
| Local Cache | Hive |
| Push Notifications | Firebase Messaging |
| Theme | Material 3 + Google Fonts (Outfit) |
| Code Generation | Freezed + json_serializable |

## Architecture

```
skool-ui/lib/
├── core/
│   ├── config/          # Environment config (AppConfig)
│   ├── constants/       # ApiEndpoints, StorageKeys, RoutePaths
│   ├── exceptions/      # Typed ApiException hierarchy
│   ├── network/         # DioClient + interceptors
│   ├── storage/         # TokenStorage (Keychain/Keystore)
│   ├── theme/           # AppTheme (Material 3, dark mode)
│   └── widgets/         # SkoolButton, SkoolTextField
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/     # AuthRemoteDataSource
│   │   │   ├── models/          # Auth domain models
│   │   │   └── repositories/    # AuthRepository
│   │   └── presentation/
│   │       ├── providers/       # Riverpod auth providers
│   │       └── screens/         # LoginScreen
│   ├── dashboard/
│   ├── attendance/
│   ├── homework/
│   ├── notifications/
│   └── profile/
│
├── routes/              # GoRouter configuration
└── main.dart
```

## Quick Start

### 1. Configure environment

```bash
cp .env.example .env
# Edit API_BASE_URL to point to your backend
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run code generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

```bash
flutter run
```

## Key Features

- **JWT Auth** with transparent refresh token rotation
- **Route guards** — unauthenticated users redirected to login
- **Role-based navigation** — adapts to student/parent/teacher/admin
- **Dark mode** — full Material 3 dark/light theme support
- **Secure storage** — tokens in Keychain (iOS) / Keystore (Android)
- **Offline detection** — connection error handling
- **Structured error types** — sealed `ApiException` hierarchy

## Screens

| Screen | Route |
|--------|-------|
| Splash | `/` |
| Login | `/login` |
| Dashboard | `/dashboard` |
| Attendance | `/attendance` |
| Homework | `/homework` |
| Notifications | `/notifications` |
| Profile | `/profile` |

## Environment Variables

See `.env.example` for all required variables.

## Firebase Setup

1. Create a Firebase project
2. Add `google-services.json` to `android/app/`
3. Add `GoogleService-Info.plist` to `ios/Runner/`
4. Uncomment the Firebase initialization in `main.dart`

## Running Tests

```bash
flutter test
```
