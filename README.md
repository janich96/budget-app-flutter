# Budget App

Budget App is a personal finance tracker built with Flutter and Firebase. It helps you keep track of expenses, accumulation goals, and financial entries in one place.

## Live Demo

Web version: https://budget-app-flutter-1678f.web.app

## What It Does

- Google sign-in
- Anonymous demo mode
- Store data in Firebase Firestore per user
- Manage expense categories
- Manage accumulation categories
- Track weekly entries and financial history
- Sync data across devices when signed in

## Tech Stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- Google Sign-In
- Bloc for state management
- GetIt for dependency injection
- GoRouter for navigation

## Project Structure

- `lib/` - application code
- `android/` - Android configuration
- `ios/` - iOS configuration
- `web/` - web entry point and assets
- `.github/workflows/` - GitHub Actions deployment workflow

## Web Deployment

The web version is deployed to Firebase Hosting through GitHub Actions.

- Pushes to the `master` branch trigger an automatic build and deploy
- The deployed site is available at the link above

## Local Setup

1. Install Flutter.
2. Run:

```bash
flutter pub get
flutter run
```

3. For web:

```bash
flutter run -d chrome
```

## Firebase

This app uses Firebase for authentication and cloud storage. Make sure your Firebase project is configured with:

- Firebase Authentication enabled
- Google sign-in enabled
- Cloud Firestore enabled
- Correct Android SHA-1 and web OAuth client configuration

## Notes

- Web sign-in uses a Firebase popup flow.
- Android sign-in uses Google Sign-In with Firebase Auth.
- Demo mode stores data locally instead of syncing to Firestore.
