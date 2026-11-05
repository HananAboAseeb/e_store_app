# Technical Research: Settings & User Account Management (Screens 86–100)

**Feature**: `specs/015-settings`  
**Date**: 2026-11-05  
**Status**: Completed  

---

## 1. Screen Unification Architecture (Screens 86–100)

### Decision
Unify closely coupled screen variants into shared, parameter-driven pages and sheets:
1. **Screens 86 & 87 Unified (`SettingsPage`)**:
   - Screen 86 represents the upper subset (Personal and Shop sections), while Screen 87 represents the complete settings menu (Personal, Shop, Account, Delete My Account button, and ShopX Version footer).
   - A single `SettingsPage` renders all sections with clean vertical scrolling so that all items are accessible seamlessly.
2. **Screens 89 & 92 Unified (`PaymentSettingsPage`)**:
   - Uses a `PaymentViewMode` enum (`cards` vs `history`) managed by `PaymentSettingsCubit`.
   - In `cards` mode (Screen 89): displays the Card carousel with an inactive circular history button (↺) and the PayPal placeholder section below.
   - In `history` mode (Screen 92): displays the Card carousel with an active blue circular history button and replaces PayPal with the `Payment History` transaction list.
3. **Screens 93 & 94 Unified (`ShippingAddressPage`)**:
   - Uses an `isEditing` boolean in `ShippingSettingsState`.
   - In read-only mode (Screen 93): shows "Choose your country" (or current country), non-editable field containers, and grey "Edit Information" button.
   - In edit mode (Screen 94): shows selectable country "Iran", active text fields, and primary blue "Save Changes" button (`PrimaryButton`).
4. **Screens 90 & 91 Unified (`AddEditCardSheet`)**:
   - Modal bottom sheet with 24.r top corner radius (`showModalBottomSheet`).
   - Accepts an optional `PaymentCardEntity? initialCard`. When `null` (Screen 90), title is "Add Card" with placeholder "Required"; when provided (Screen 91), title is "Edit Card" pre-populated with card parameters.

### Rationale
- Prevents code duplication for virtually identical layouts.
- Preserves smooth state transitions without unnecessary page pushes and pop animation latency.
- Complies strictly with the Constitution and Feature-First Clean Architecture principles.

### Alternatives Considered
- *Creating 15 separate page classes*: Rejected due to high code duplication (~60% duplicated widget code) and violation of DRY.
- *Separate routes for cards and history*: Rejected because toggling history in Figma (Screens 89 and 92) is an in-place section swap controlled by the circular icon button in the app bar.

---

## 2. Multi-Cubit Architecture within a Single Feature

### Decision
Partition the feature presentation logic into five cohesive, targeted Cubits:
1. `SettingsCubit`: Main menu navigation, version info, account deletion trigger (Screens 86, 87, 99).
2. `AccountCubit`: User profile data, credentials inspection, avatar (Screen 88).
3. `PaymentSettingsCubit`: Cards carousel, view mode toggle, card add/edit, transaction history (Screens 89, 90, 91, 92).
4. `ShippingSettingsCubit`: Shipping address parameters, read-only vs editable mode, validation, saving (Screens 93, 94).
5. `PreferencesCubit`: Country search/selection, language selection, currency selection, sizing standard selection, and About ShopX details (Screens 95, 96, 97, 98, 100).

### Rationale
- Adheres to Single Responsibility Principle (SRP).
- Prevents bloated "God" Cubits where editing a card triggers re-renders of shipping address or country search.
- Enables granular widget rebuilds via targeted `BlocBuilder` and `BlocSelector`.

### Alternatives Considered
- *Single `SettingsCubit` for all 15 screens*: Rejected because managing cards, transactions, addresses, search queries, profile editing, and modal dialogs in one cubit creates excessive state complexity and unnecessary re-renders.

---

## 3. Strict Design Token Mapping (Rule #11)

### Decision
Add the following 6 specific design tokens to `lib/core/theme/app_colors.dart` before widget implementation:
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

### Rationale
- Guarantees 100% token adherence (Rule #11) with zero hardcoded `Color(0x...)` values in widgets.
- All tokens are extracted directly from the Figma design references (`87`, `92`, `96`, `99`, `100`).

---

## 4. Component Reuse & DRY Strategy

### Existing Shared Widgets Reused
- `CustomBottomNavBar` (`lib/shared/navigation/`): Persistent navigation bar on primary screens with Profile active.
- `PrimaryButton` (`lib/shared/widgets/`): Primary blue action button for `Save Changes`.
- `AppText` (`lib/shared/widgets/`): Headings, labels, and text styling.
- `AppContainer` (`lib/shared/widgets/`): Grouped grey surface containers.
- `ModalCloseButton` (`lib/shared/widgets/`): Modal `✕` close buttons on Add/Edit Card sheets.
- `MetaPill` (`lib/shared/widgets/`): Metadata status pills.
- `PaymentCardItem` (`lib/features/payment/presentation/widgets/payment_card_item.dart`): Exact card presentation for Mastercard and Visa carousel cards.

### Justification for New Reusable Widgets
1. **`SettingsMenuItem`**: Displays row title, optional trailing value, and chevron right with ripple effect inside grouped containers. No existing shared widget provides this specific layout.
2. **`SettingsSectionHeader`**: Standardizes section title typography and padding across `Personal`, `Shop`, and `Account`.
3. **`PaymentHistoryRow`**: Displays transaction cards with colored shopping bag icon, order number, timestamp, and signed price.
4. **`PreferenceOptionTile`**: Displays full-width rounded selection pills with soft blue/grey surface and circular checkmark indicator for Language, Currency, and Sizes.
5. **`CountryListItem`**: Renders clean alphabetical country list items with selection callback.
6. **`ShippingFieldGroup`**: Renders label above soft blue-tinted container for read-only and editable address inputs.
7. **`DeleteAccountDialog`**: Standardized alert dialog with warning exclamation mark, warning copy, Cancel pill, and Delete pill.
8. **`AddEditCardSheet`**: Modal bottom sheet for adding or editing credit/debit cards.

