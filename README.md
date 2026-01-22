# sandwich_shop

Sandwich Shop is a small Flutter sample app used for teaching app architecture,
state management, and testing. The app demonstrates a simple order screen with
quantity controls, sandwich sizing, toasting option, notes, and a pricing
repository used by unit and widget tests.

This repository was developed as part of coursework (Worksheet 3/4) and
includes a focus on separation of concerns: UI (views), repositories (logic),
and tests.

---

## Quick start

Prerequisites:
- Install Flutter (release channel compatible with the project's SDK).
- A working `flutter` on your PATH.

Run the app on a connected device or simulator:

```bash
flutter pub get
flutter run
```

Run the test suite (unit + widget tests):

```bash
flutter pub get
flutter test --reporter=expanded
```

Note: widget tests in this workspace currently use a test-friendly entrypoint
`lib/app_entry.dart`. The main application entrypoint is `lib/main.dart`. If you
change one, ensure tests import the right entry file.

---

## Key features

- Order screen with increment / decrement quantity controls.
- Size toggle (six-inch / footlong) which affects pricing.
- Toast option and free-text notes input.
- `OrderRepository` encapsulates quantity logic.
- `PricingRepository` encapsulates pricing logic and size enum.
- Unit tests for repositories and widget tests for UI behavior.

---

## Project structure (important files)

- `lib/main.dart` — canonical app entrypoint (MaterialApp -> `OrderScreen`).
- `lib/app_entry.dart` — test-friendly entrypoint used by widget tests.
- `lib/views/app_styles.dart` — shared text styles used by the UI.
- `lib/repositories/order_repository.dart` — manages quantity and business rules.
- `lib/repositories/pricing_repository.dart` — pricing rules and `SandwichSize` enum.
- `test/` — unit and widget tests. Example tests:
	- `test/repositories/order_repository_test.dart`
	- `test/views/widget_test.dart`
	- `test/widget_test.dart`

Platform folders (iOS/Android/web/macos/linux/windows) are standard Flutter
scaffold directories used for platform builds.

---

## Notes for contributors

- The repository is on branch `worksheet4` for the Worksheet 4 work.
- `lib/app_entry.dart` was added as a stable entry used by tests while
	`lib/main.dart` was restored; you may remove `app_entry.dart` and update
	tests to point to `lib/main.dart` if preferred.
- `flutter analyze` may report non-fatal lints; please run the analyzer and
	tests locally before opening PRs.

---

## Sign-off

Prepared and verified by the assistant on behalf of the developer.
# sandwich_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
