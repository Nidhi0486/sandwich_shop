# 🥪 Sandwich Shop — Sandwich Counter (mysandwich_counter)

Small Flutter app for creating sandwich orders. Users pick size (six‑inch / footlong), bread, toasted or not, add notes and adjust quantity. Price updates automatically using a repository-based pricing class to make logic testable.

## Features
- Select sandwich size (Six‑inch / Footlong)
- Select bread type (enum)
- Toggle toasted / untoasted
- Add notes
- Increment / decrement quantity with limits (OrderRepository)
- Dynamic total price calculation (PricingRepository)
- Unit tests for repositories and widget tests for UI interactions

## Prerequisites
- Flutter SDK (stable) installed and on PATH
- A device or emulator (Android/iOS) or desktop target

## Quick start (Windows)
1. Open a terminal in the project root:
   cd "c:\Users\nidhi\OneDrive\Desktop\programing\sandwich_shop\mysandwich_counter"
2. Get dependencies:
   flutter pub get
3. Run on a device/emulator:
   flutter run
4. Run tests:
   flutter test

## Project structure (important files)
- lib/
  - main.dart — app entry, views and simple wiring
  - repositories/
    - order_repository.dart — quantity business logic
    - pricing_repository.dart — pricing logic
  - views/
    - app_styles.dart — theme and reusable styles
- test/
  - repositories/ — unit tests for repositories
  - views/ — widget tests (switches, buttons, displays)

## Testing
- Unit tests: tests in `test/repositories` (e.g., OrderRepository, PricingRepository)
- Widget tests: tests in `test/views` (switch toggles, buttons, OrderItemDisplay)
Run all tests:
```
flutter test
```

## Notes about architecture
This project follows a simple MVVM-style separation:
- Repositories for business logic and state
- Views for UI widgets
- (Optional) view_models to mediate between views and repositories

This separation makes logic easy to unit test (see repository tests).

## Contributing
- Create a feature branch, commit changes with clear messages, run tests locally, then open a PR.
- Keep UI and business logic separate; update tests when behavior changes.

## License & Contact
This is a student / learning project. For questions or help, open an issue or contact the project owner.

```// filepath: c:\Users\nidhi\OneDrive\Desktop\programing\sandwich_shop\README.md
# 🥪 Sandwich Shop — Sandwich Counter (mysandwich_counter)

Small Flutter app for creating sandwich orders. Users pick size (six‑inch / footlong), bread, toasted or not, add notes and adjust quantity. Price updates automatically using a repository-based pricing class to make logic testable.

## Features
- Select sandwich size (Six‑inch / Footlong)
- Select bread type (enum)
- Toggle toasted / untoasted
- Add notes
- Increment / decrement quantity with limits (OrderRepository)
- Dynamic total price calculation (PricingRepository)
- Unit tests for repositories and widget tests for UI interactions

## Prerequisites
- Flutter SDK (stable) installed and on PATH
- A device or emulator (Android/iOS) or desktop target

## Quick start (Windows)
1. Open a terminal in the project root:
   cd "c:\Users\nidhi\OneDrive\Desktop\programing\sandwich_shop\mysandwich_counter"
2. Get dependencies:
   flutter pub get
3. Run on a device/emulator:
   flutter run
4. Run tests:
   flutter test

## Project structure (important files)
- lib/
  - main.dart — app entry, views and simple wiring
  - repositories/
    - order_repository.dart — quantity business logic
    - pricing_repository.dart — pricing logic
  - views/
    - app_styles.dart — theme and reusable styles
- test/
  - repositories/ — unit tests for repositories
  - views/ — widget tests (switches, buttons, displays)

## Testing
- Unit tests: tests in `test/repositories` (e.g., OrderRepository, PricingRepository)
- Widget tests: tests in `test/views` (switch toggles, buttons, OrderItemDisplay)
Run all tests:
```
flutter test
```

## Notes about architecture
This project follows a simple MVVM-style separation:
- Repositories for business logic and state
- Views for UI widgets
- (Optional) view_models to mediate between views and repositories

This separation makes logic easy to unit test (see repository tests).

## Contributing
- Create a feature branch, commit changes with clear messages, run tests locally, then open a PR.
- Keep UI and business logic separate; update tests when behavior changes.

## License & Contact
This is a student / learning project. For questions or help, open an issue or contact the project owner.
