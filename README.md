



# AyiProject

Project developed using flutter 2.x, bloc State Management with clean architecture TDD and support multiple language.

Demo: https://drive.google.com/file/d/1V6FIHQPvmTo79FH-uPzp_0poegUO23ek/preview

<img width="500" alt="screenshoot" src="https://user-images.githubusercontent.com/5361004/197741462-4d465e87-1cd8-4d62-a3bb-fdbdeb3670e0.png">

# Team Structure

Note: This section must be updated according to latest situation.

| Role           | Team                      | 
|----------------|---------------------------|
| Developer      | Zay <syukruzay@gmail.com> |

# Reference
1. Flutter https://flutter.dev/docs/get-started/codela
2. TDD : https://resocoder.com/flutter-clean-architecture-tdd

## Installation

This repository requires [Flutter](https://flutter.dev/docs/get-started/install) to be installed and
present in your development environment.

Clone the project and enter the project folder.

```sh
git clone https://github.com/zaycode/ayiproject.git
cd ayiproject
```


Get the dependencies.

```sh
flutter pub get
```

Run the app via command line or through your development environment. (optional)

```sh
flutter run lib/main.dart
```


## Development Notes

- All developer must initiate and use [git-flow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) before starting development. Suggested to use SourceTree or other GUI based.
- Protected branch only available for maintainers: `develop`, `master`. Designed to be merged from feature or hotfix branches.
- All development, should always be in feature branches.

> **Warning**: Never push directly to `master` or `develop` branch unless necessary or approved by project leader.

## Environment Notes

This project implements 3 environments. Each environments has different variable for its configurations.
detail for each environment listed below.

## Development
- This environment is for  internal developers and leaders to collaborate in daily development.
- namespace used for this environment is  `com.fyi.app.dev`
- Firebase, Appstore, GoogleStore app will also use this namespace and create the firebase project and apps respectively.

# Staging
- This environment is for  QA team and client to check the latest progress or stable features
- namespace used for this environment is `com.fyi.app.staging`
- Firebase, Appstore, GoogleStore app will also use this namespace.
- Firebase, Appstore, GoogleStore app will also use this namespace and create the firebase project and apps respectively.
- Use beta test track(android) and internal test(iOS) to distribute app(if access given) or codemagic

# Production
- This environment is for live App using real data and environment for client
- namespace used for this environment is `com.fyi.app`
- Firebase, Appstore, GoogleStore app will also use this namespace.
- Firebase, Appstore, GoogleStore app will also use this namespace and create the firebase project and apps respectively.
- Use production track(android/iOS) to publish it in App Store/ Play Store
