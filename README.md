# ShopX

**ShopX** is a cross-platform Flutter e-commerce mobile application engineered with **Feature-First Clean Architecture**, reactive **Cubit** state management, and responsive Figma-aligned design tokens.

`Flutter` · `Dart >=3.0.0 <4.0.0` · `Clean Architecture` · `flutter_bloc` · `go_router` · `EN / AR`

---

## Key Features

- **Onboarding & Authentication:** Welcome flow, registration, login, OTP verification, and password recovery (`auth`).
- **Storefront & Discovery:** Personalized home feed, shop catalog, nested categories, live flash sales, and keyword/image search (`home`, `shop`, `categories`, `flash_sale`, `search`).
- **Product & Shopping Flow:** Product details with reviews and variant selection, wishlist & recently viewed items, cart management, checkout, and payment methods (`product`, `wishlist`, `cart`, `checkout`, `payment`).
- **Orders, Care & Account:** Order history and live step-by-step tracking, customer care chat, user profile with rewards/activity, and full app preferences including currency, sizing, light/dark theme, and Arabic/English localization (`orders`, `chat`, `profile`, `settings`, `theme`).

---

## Engineering Highlights

- **Modular Clean Architecture:** 16 self-contained feature modules structured across `data`, `domain`, and `presentation` layers, wired via `get_it` dependency injection and `dartz` (`Either<Failure, T>`) error handling.
- **Predictable State & Routing:** Immutable `Equatable` states powered by `flutter_bloc` (`Cubit`) and persistent bottom-navigation shell routing via `go_router`.
- **Responsive UI & Localization:** Pixel-scaled layouts with `flutter_screenutil`, shimmer loading states, centralized theme tokens, and full RTL/LTR support (`ar` / `en`) via `easy_localization`.
- **Flavors & Data Contracts:** Isolated `dev` and `prod` build flavors (`flutter_flavor` + `envied`); currently backed by structured mock data sources behind repository contracts ready for live API integration.

---

## Tech Stack

| Layer | Technologies |
| --- | --- |
| **Core & Architecture** | Flutter, Dart, `flutter_bloc`, `equatable`, `get_it`, `dartz`, `go_router` |
| **Networking & Storage** | `dio`, `internet_connection_checker_plus`, `hive`, `shared_preferences`, `flutter_secure_storage` |
| **UI & Localization** | `flutter_screenutil`, `easy_localization`, `shimmer`, `cached_network_image` |
| **Config & Tooling** | `flutter_flavor`, `envied`, `build_runner`, `flutter_launcher_icons`, `flutter_lints` |

---

## Getting Started

### Prerequisites

- Flutter SDK (`flutter doctor` passing)
- Dart SDK `>=3.0.0 <4.0.0`

### Setup & Run

```bash
# 1. Install dependencies
flutter pub get

# 2. Run development flavor
flutter run --flavor dev -t lib/main_dev.dart

# 3. Run production flavor
flutter run --flavor prod -t lib/main_prod.dart
```

---

## Verification & Tooling

```bash
# Run static analysis
flutter analyze

# Run automated unit and widget tests (51 tests)
flutter test
```

<details>
<summary>Code generation & asset commands</summary>

```bash
# Generate Hive adapters and Envied environment config
dart run build_runner build

# Regenerate localization keys (assets/translations -> lib/generated/locale_keys.g.dart)
dart run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart

# Regenerate Android & iOS launcher icons
dart run flutter_launcher_icons
```

</details>
