# Implementation Plan: Settings & User Account Management (Screens 86–100)

**Branch**: `015-settings` | **Date**: 2026-11-05 | **Spec**: [specs/015-settings/spec.md](spec.md)

**Input**: Feature specification from `specs/015-settings/spec.md` covering Screens 86–100.

---

## Summary

The Settings feature delivers complete user account management, payment method administration, regional configuration, and application branding:
1. **Settings Main (Screens 86, 87)**: Categorized hub for `Personal`, `Shop`, and `Account` sections, `Delete My Account` button, and version footer (`ShopX Version 1.0 June, 2026`).
2. **Profile Credentials (Screen 88)**: Avatar inspection, username, email, and masked password with editing trigger.
3. **Payment Methods & History (Screens 89, 90, 91, 92)**: Credit/debit card carousel (Mastercard & Visa), Add Card and Edit Card modal sheets, and toggleable Payment History with color-coded transaction cards.
4. **Shipping Address (Screens 93, 94)**: Dual-mode address screen (read-only view with "Edit Information" toggle, and editable view with "Save Changes").
5. **Regional Preferences (Screens 95, 96, 97, 98)**: Country search and list, 6-language selector, 2-currency selector, and 3-size standard selector with active checkmark styling.
6. **Delete Account Warning (Screen 99)**: Centered confirmation modal with exclamation warning badge, Cancel black pill, and Delete red pill.
7. **About ShopX (Screen 100)**: Branding page with top radial blue glow, ShopX shopping bag logo, UI kit description, and support email.

The implementation strictly follows Feature-First Clean Architecture, the project Constitution v1.2.0, Rule #11 (Strict Design Tokens), Rule #12 (FVM-Only CLI), and DRY component reuse.

---

## Technical Context

**Language/Version**: Dart 3.5.4 (Flutter 3.24.5 via FVM)  
**Primary Dependencies**: `flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`  
**Storage**: In-memory mock data source (`SettingsMockDataSourceImpl`)  
**Testing**: `flutter_test` (unit & widget tests in `test/features/settings/`)  
**Target Platform**: Android, iOS  
**Project Type**: Mobile Application Feature Module  
**Performance Goals**: 60 fps smooth scrolling and transition response, instant preference toggles (< 16ms), seamless in-place section swap between PayPal and History  
**Constraints**: Zero hardcoded colors/dimensions (Rule #11), FVM CLI only (Rule #12), no verification commands until final phase (Rule #1), zero new asset generation (Rule #2)  
**Scale/Scope**: 15 design reference screens, 5 Cubits, 11 UseCases, 1 standalone feature module  

---

## Constitution & Rule Compliance Check

| Rule | Requirement | Compliance Plan |
|---|---|---|
| Rule 1 | Verification Timing | Save static analysis strictly for the final phase (`fvm flutter analyze` at completion) |
| Rule 2 | Asset Policy | Reuse existing assets from `assets/images/` and `assets/design_references/`; 0 new assets generated |
| Rule 3 | Architectural Adherence | Feature-First Clean Architecture (`domain/`, `data/`, `presentation/`, `di/`) |
| Rule 4 | Code Quality & Design Patterns | UseCases with `Either<Failure, T>`, `safeCall` in repository, Cubits with `Equatable` states |
| Rule 5 | Dimensions & Frameworks | ScreenUtil (`.w`, `.h`, `.r`, `.sp`), `go_router` for navigation, `flutter_bloc` |
| Rule 6 | Component Reuse (DRY) | Reuse `CustomBottomNavBar`, `PrimaryButton`, `AppText`, `AppContainer`, `ModalCloseButton`, `MetaPill`, `PaymentCardItem` |
| Rule 7 | Clean Architecture Layers | Complete Domain, Data, Presentation layers with DI registration and routing |
| Rule 8 | Phase 1 Data Scope | Mock data source with 1 profile, 2 cards, 4 history records, 1 address, 20+ countries, 6 languages, 2 currencies, 3 sizes |
| Rule 9 | Loading Experience | Shimmer placeholders for asynchronous loading states |
| Rule 10 | Visual Perfection | Pixel-perfect 1:1 match with Figma references (`86` through `100`) |
| Rule 11 | Strict Token Enforcement | 100% tokens from `AppColors`, `AppSpacing`, `AppTypography`. Add new tokens to `app_colors.dart` FIRST |
| Rule 12 | FVM-Only CLI Commands | Always use `fvm flutter` for all verification and build commands |

---

## Design Tokens to Add in Phase 1 (`lib/core/theme/app_colors.dart`)

The following tokens will be added to `AppColors` before widget implementation:
```dart
// ─────────────────────────────────────────────
// Settings Feature Colors (Screens 86–100)
// ─────────────────────────────────────────────
/// Soft pink background for Delete My Account button (Screen 87)
static const Color deleteAccountBg = Color(0xFFFFECEB);

/// Circular light grey background for Delete warning dialog icon badge (Screen 99)
static const Color deleteWarningBg = Color(0xFFEAEAEA);

/// Coral red shopping bag icon color for debit transactions in Payment History (Screen 92)
static const Color historyDebitIcon = Color(0xFFFF5B60);

/// Soft pink background fill for debit transaction card in Payment History (Screen 92)
static const Color historyDebitCardBg = Color(0xFFFFF0F2);

/// Primary blue shopping bag icon color for credit transactions in Payment History (Screen 92)
static const Color historyCreditIcon = primary400;

/// Soft blue radial glow color at top of About ShopX screen (Screen 100)
static const Color aboutGlow = Color(0xFFE1EDFF);

/// Active selection background for language, currency, sizes, and country tiles
static const Color activeSelectionBg = primarySoft;
```

---

## Component Reuse & DRY Strategy

### Existing Shared Widgets (Reused)
- **`CustomBottomNavBar`** (`lib/shared/navigation/`): Reused on primary settings screens with Profile tab (`NavEnum.profile`) active.
- **`PrimaryButton`** (`lib/shared/widgets/`): Reused for `Save Changes` on Add/Edit Card sheets (90, 91) and Shipping Address (94).
- **`AppText`** (`lib/shared/widgets/`): Reused for headings, subtitles, and labels.
- **`AppContainer`** (`lib/shared/widgets/`): Reused for rounded grey grouping containers.
- **`ModalCloseButton`** (`lib/shared/widgets/`): Reused for `✕` close button in Add/Edit Card sheets (90, 91).
- **`MetaPill`** (`lib/shared/widgets/`): Reused for status tags and phone number pills.
- **`PaymentCardItem`** (`lib/features/payment/presentation/widgets/payment_card_item.dart`): Reused for Mastercard and Visa carousel card presentation (already has interlocking circles, VISA typography, gear icon, and token styling).

### New Specialized Widgets (Justified)
- **`SettingsMenuItem`**: Row with title, optional metadata label, and chevron right.
- **`SettingsSectionHeader`**: Standardized bold section headers (`Personal`, `Shop`, `Account`).
- **`PaymentHistoryRow`**: Transaction card with colored shopping bag icon, order number, timestamp, and signed price.
- **`PreferenceOptionTile`**: Selection pill with soft blue/grey surface and circular checkmark indicator.
- **`CountryListItem`**: Clean alphabetical country list item for search and selection.
- **`ShippingFieldGroup`**: Label above soft blue-tinted container for read-only and editable address inputs.
- **`DeleteAccountDialog`**: Centered confirmation alert dialog with warning exclamation mark, warning copy, Cancel black pill, and Delete red pill.
- **`AddEditCardSheet`**: Modal bottom sheet for adding or modifying cards.

---

## Project Structure & Architecture

```text
lib/
├── core/
│   └── theme/
│       └── app_colors.dart                                  # Added new settings tokens
├── features/
│   └── settings/
│       ├── settings_injection.dart                          # DI container registration
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── user_account_entity.dart
│       │   │   ├── payment_card_entity.dart
│       │   │   ├── payment_history_entity.dart
│       │   │   ├── shipping_address_entity.dart
│       │   │   ├── country_entity.dart
│       │   │   ├── language_entity.dart
│       │   │   ├── currency_entity.dart
│       │   │   └── size_standard_entity.dart
│       │   ├── repositories/
│       │   │   └── settings_repository.dart
│       │   └── usecases/
│       │       ├── get_profile_usecase.dart
│       │       ├── update_profile_usecase.dart
│       │       ├── get_payment_cards_usecase.dart
│       │       ├── add_payment_card_usecase.dart
│       │       ├── update_payment_card_usecase.dart
│       │       ├── get_payment_history_usecase.dart
│       │       ├── get_shipping_address_usecase.dart
│       │       ├── update_shipping_address_usecase.dart
│       │       ├── get_preferences_usecase.dart
│       │       ├── update_preference_usecase.dart
│       │       └── delete_account_usecase.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── settings_mock_data_source.dart
│       │   │   └── settings_mock_data_source_impl.dart
│       │   ├── models/
│       │   │   ├── user_account_model.dart
│       │   │   ├── payment_card_model.dart
│       │   │   ├── payment_history_model.dart
│       │   │   ├── shipping_address_model.dart
│       │   │   ├── country_model.dart
│       │   │   ├── language_model.dart
│       │   │   ├── currency_model.dart
│       │   │   └── size_standard_model.dart
│       │   └── repositories/
│       │       └── settings_repository_impl.dart
│       └── presentation/
│           ├── cubits/
│           │   ├── settings_cubit.dart & settings_state.dart
│           │   ├── account_cubit.dart & account_state.dart
│           │   ├── payment_settings_cubit.dart & payment_settings_state.dart
│           │   ├── shipping_settings_cubit.dart & shipping_settings_state.dart
│           │   └── preferences_cubit.dart & preferences_state.dart
│           ├── pages/
│           │   ├── settings_page.dart                       # Screens 86, 87 unified
│           │   ├── your_profile_page.dart                   # Screen 88
│           │   ├── payment_settings_page.dart               # Screens 89, 92 unified
│           │   ├── shipping_address_page.dart               # Screens 93, 94 unified
│           │   ├── country_selection_page.dart              # Screen 95
│           │   ├── language_selection_page.dart             # Screen 96
│           │   ├── currency_selection_page.dart             # Screen 97
│           │   ├── sizes_selection_page.dart                # Screen 98
│           │   └── about_shopx_page.dart                    # Screen 100
│           └── widgets/
│               ├── settings_menu_item.dart
│               ├── settings_section_header.dart
│               ├── payment_history_row.dart
│               ├── preference_option_tile.dart
│               ├── country_list_item.dart
│               ├── shipping_field_group.dart
│               ├── delete_account_dialog.dart               # Screen 99
│               └── add_edit_card_sheet.dart                 # Screens 90, 91 unified
```

---

## Permanent Project Rules Reference

All plans MUST strictly incorporate and reflect the Permanent Project Rules from `.specify/memory/constitution.md`:
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **CLI & THEME ENVIRONMENT COMPATIBILITY**: The project is compatible across both local Flutter (3.24.5) and newer Flutter toolchains. The theme in `app_theme.dart` and `component_themes.dart` is designed to be version-agnostic (avoiding version-incompatible APIs such as `CardTheme` vs `CardThemeData`). Do NOT re-introduce `CardThemeData` or `CardTheme` into `ThemeData` or `AppComponentThemes` to preserve seamless compilation and runtime execution on the user's Flutter environment.
