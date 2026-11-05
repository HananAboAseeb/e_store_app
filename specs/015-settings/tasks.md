# Tasks: Settings & User Account Management (Screens 86–100)

**Input**: Design documents from `specs/015-settings/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/settings_contracts.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: All permanent project rules in `.specify/instructions/permanent-project-rules.md` and Constitution v1.2.0  
**Verification Timing**: No `fvm flutter analyze` or `fvm flutter test` until Phase 10 (final phase only)  

---

## Format: `[ID] [P?] [Story?] Description with file path`
- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g. `[US1]`, `[US2]`, `[US3]`, `[US4]`, `[US5]`, `[US6]`, `[US7]`)
- Every task includes explicit file paths

---

## Phase 1: Setup & Token Scaffolding (Shared Infrastructure)

**Purpose**: Register all 7 new design tokens in `AppColors` FIRST before any UI implementation begins, and establish the feature directory structure.

- [X] T001 Register 7 new design tokens (`deleteAccountBg`, `deleteWarningBg`, `historyDebitIcon`, `historyDebitCardBg`, `historyCreditIcon`, `aboutGlow`, `activeSelectionBg`) in `lib/core/theme/app_colors.dart` FIRST.
- [X] T002 [P] Establish directory structure for settings subpackages under `lib/features/settings/` (`domain/entities`, `domain/repositories`, `domain/usecases`, `data/models`, `data/datasources`, `data/repositories`, `presentation/cubits`, `presentation/pages`, `presentation/widgets`).

---

## Phase 2: Foundational (Domain, Data, DI & Routing)

**Purpose**: Core Clean Architecture contracts, entities, use cases, data models, mock data sources, DI container, and navigation routing.

- [X] T003 [P] Create domain entities (`UserAccountEntity`, `PaymentCardEntity`, `PaymentHistoryEntity`, `ShippingAddressEntity`, `CountryEntity`, `LanguageEntity`, `CurrencyEntity`, `SizeStandardEntity`, `SettingsMenuItemEntity`) in `lib/features/settings/domain/entities/`.
- [X] T004 [P] Define `SettingsRepository` interface contract in `lib/features/settings/domain/repositories/settings_repository.dart`.
- [X] T005 [P] Implement 11 UseCases (`GetProfileUseCase`, `UpdateProfileUseCase`, `GetPaymentCardsUseCase`, `AddPaymentCardUseCase`, `UpdatePaymentCardUseCase`, `GetPaymentHistoryUseCase`, `GetShippingAddressUseCase`, `UpdateShippingAddressUseCase`, `GetPreferencesUseCase`, `UpdatePreferenceUseCase`, `DeleteAccountUseCase`) in `lib/features/settings/domain/usecases/`.
- [X] T006 [P] Implement 8 Data Models (`UserAccountModel`, `PaymentCardModel`, `PaymentHistoryModel`, `ShippingAddressModel`, `CountryModel`, `LanguageModel`, `CurrencyModel`, `SizeStandardModel`) extending entities with factory constructors in `lib/features/settings/data/models/`.
- [X] T007 Implement `SettingsMockDataSource` and `SettingsMockDataSourceImpl` in `lib/features/settings/data/datasources/settings_mock_data_source.dart` and `lib/features/settings/data/datasources/settings_mock_data_source_impl.dart` (mocking Romina profile, 2 cards Mastercard/Visa, 4 transactions, 1 shipping address, 20+ countries, 6 languages, 2 currencies, 3 sizes).
- [X] T008 Implement `SettingsRepositoryImpl` in `lib/features/settings/data/repositories/settings_repository_impl.dart` wrapping data source calls with `safeCall`.
- [X] T009 [P] Register route constants (`kSettingsPage`, `kSettingsProfilePage`, `kSettingsPaymentPage`, `kSettingsShippingPage`, `kSettingsCountryPage`, `kSettingsLanguagePage`, `kSettingsCurrencyPage`, `kSettingsSizesPage`, `kSettingsAboutPage`) in `lib/config/routing/route_names.dart` and mount routes in `lib/config/routing/app_router.dart`.
- [X] T010 Register all 5 Cubits, 11 UseCases, `SettingsRepository`, and `SettingsMockDataSource` in `lib/features/settings/settings_injection.dart` and bind into `lib/core/di/injection.dart`.

**Checkpoint**: Foundation complete — data contracts, mock data sources, DI bindings, and routing ready for presentation layer.

---

## Phase 3: User Story 1 (P1) — Settings Main (Screens 86, 87 unified) 🎯 MVP

**Goal**: Deliver the primary Settings hub with Personal, Shop, and Account sections, "Delete My Account" button, and version footer.  
**Independent Test**: Navigate to `/settings`; verify all 3 grouped containers, metadata values (Country: Iran, Currency: $ USD, Sizes: UK, Language: English), Delete button in soft pink container, and version text.

- [X] T011 [US1] Implement `SettingsCubit` and `SettingsState` in `lib/features/settings/presentation/cubits/settings_cubit.dart` and `lib/features/settings/presentation/cubits/settings_state.dart` (managing main menu structure, navigation events, and version info).
- [X] T012 [P] [US1] Implement `SettingsSectionHeader` in `lib/features/settings/presentation/widgets/settings_section_header.dart` (standardized section title using `AppTypography.h3` and `AppSpacing`).
- [X] T013 [P] [US1] Implement `SettingsMenuItem` in `lib/features/settings/presentation/widgets/settings_menu_item.dart` (row with title, optional trailing subtitle/metadata, and chevron right with ripple effect).
- [X] T014 [US1] Implement unified `SettingsPage` in `lib/features/settings/presentation/pages/settings_page.dart` (Screens 86 & 87: Personal, Shop, and Account grouped containers via `AppContainer`, Delete My Account pink button via `AppColors.deleteAccountBg`, ShopX Version 1.0 footer, and persistent `CustomBottomNavBar`).

**Checkpoint**: User Story 1 complete and independently verifiable as the core Settings MVP.

---

## Phase 4: User Story 2 (P2) — Your Profile (Screen 88)

**Goal**: Deliver the User Profile inspection screen displaying avatar, username, email, and masked password with editing trigger.  
**Independent Test**: Navigate to `/settings/profile`; verify circular avatar portrait (80x80), formatted fields in soft blue containers (`AppColors.primarySoft`), and grey `Edit Information` button.

- [X] T015 [US2] Implement `AccountCubit` and `AccountState` in `lib/features/settings/presentation/cubits/account_cubit.dart` and `lib/features/settings/presentation/cubits/account_state.dart` (managing profile data loading, editing state, and credential updates).
- [X] T016 [US2] Implement `YourProfilePage` in `lib/features/settings/presentation/pages/your_profile_page.dart` (Screen 88: circular 80x80 avatar using `assets/images/profile_picture.png`, Username, Email, Password fields in `AppColors.primarySoft` containers, and grey `Edit Information` pill button).

**Checkpoint**: User Story 2 complete and independently verifiable.

---

## Phase 5: User Story 3 (P3) — Payment Methods (Screens 89, 92 unified)

**Goal**: Deliver the Payment Methods management screen with card carousel, circular History toggle (↺), circular Add button (+), PayPal placeholder, and transaction history.  
**Independent Test**: Navigate to `/settings/payment`; swipe Mastercard and Visa cards, tap History button (↺) to toggle between PayPal section and color-coded Payment History cards.

- [X] T017 [US3] Implement `PaymentSettingsCubit` and `PaymentSettingsState` in `lib/features/settings/presentation/cubits/payment_settings_cubit.dart` and `lib/features/settings/presentation/cubits/payment_settings_state.dart` (managing `PaymentViewMode.cards` vs `history`, card list, and transactions).
- [X] T018 [P] [US3] Implement `PaymentHistoryRow` in `lib/features/settings/presentation/widgets/payment_history_row.dart` (transaction card with blue or coral red bag icon `assets/images/icons/Bag 2.png`, order number, date, and signed price formatted with `AppColors.historyDebitCardBg` / `AppColors.historyDebitIcon`).
- [X] T019 [US3] Implement unified `PaymentSettingsPage` in `lib/features/settings/presentation/pages/payment_settings_page.dart` (Screens 89 & 92: card carousel reusing `PaymentCardItem` for Mastercard/Visa, circular History ↺ toggle button, circular Add + button, PayPal section in card mode, and Payment History list in history mode).

**Checkpoint**: User Story 3 complete and independently verifiable.

---

## Phase 6: User Story 4 (P3) — Add/Edit Card (Screens 90, 91 unified)

**Goal**: Deliver the Add/Edit Card bottom sheet modal for creating and updating payment cards with field validation.  
**Independent Test**: Tap Add button (+) to open Screen 90 with blank fields; tap card gear icon to open Screen 91 with pre-filled details; verify Save Changes updates card state.

- [X] T020 [P] [US4] Implement unified `AddEditCardSheet` in `lib/features/settings/presentation/widgets/add_edit_card_sheet.dart` (Screens 90 & 91: bottom sheet modal with 24.r radius, `ModalCloseButton`, form fields in `AppColors.primarySoft`, pre-filled fields if `initialCard != null`, and `PrimaryButton('Save Changes')`).
- [X] T021 [US4] Integrate `AddEditCardSheet.show(context)` trigger on Add (+) button and Card gear settings icon inside `PaymentSettingsPage` in `lib/features/settings/presentation/pages/payment_settings_page.dart`.

**Checkpoint**: User Story 4 complete and independently verifiable.

---

## Phase 7: User Story 5 (P3) — Shipping Address (Screens 93, 94 unified)

**Goal**: Deliver the Shipping Address management screen supporting both read-only inspection and active in-place editing.  
**Independent Test**: Navigate to `/settings/shipping`; verify read-only fields and grey "Edit Information" button (Screen 93); tap button to enter edit mode with blue "Save Changes" button (Screen 94).

- [X] T022 [US5] Implement `ShippingSettingsCubit` and `ShippingSettingsState` in `lib/features/settings/presentation/cubits/shipping_settings_cubit.dart` and `lib/features/settings/presentation/cubits/shipping_settings_state.dart` (handling `isEditing` toggle, address load, edit, and save).
- [X] T023 [P] [US5] Implement `ShippingFieldGroup` in `lib/features/settings/presentation/widgets/shipping_field_group.dart` (label above soft blue container with optional `MetaPill` or text editing support).
- [X] T024 [US5] Implement unified `ShippingAddressPage` in `lib/features/settings/presentation/pages/shipping_address_page.dart` (Screens 93 & 94: country selector row with blue globe icon, address fields in `ShippingFieldGroup`, grey `Edit Information` button in read-only mode, and blue `PrimaryButton('Save Changes')` in edit mode).

**Checkpoint**: User Story 5 complete and independently verifiable.

---

## Phase 8: User Story 6 (P3) — Preferences (Screens 95, 96, 97, 98)

**Goal**: Deliver Regional & Shopping Preferences (Country search/selection, Language selection, Currency selection, and Size standard selection).  
**Independent Test**: Navigate to each preferences route; select options and verify immediate active checkmark highlight and state persistence.

- [X] T025 [US6] Implement `PreferencesCubit` and `PreferencesState` in `lib/features/settings/presentation/cubits/preferences_cubit.dart` and `lib/features/settings/presentation/cubits/preferences_state.dart` (managing country search/selection, language selection, currency selection, and size selection).
- [X] T026 [P] [US6] Implement `PreferenceOptionTile` in `lib/features/settings/presentation/widgets/preference_option_tile.dart` (full-width rounded selection pill with active `AppColors.activeSelectionBg` / inactive `AppColors.surfaceAnnouncement`, and blue circular checkmark icon).
- [X] T027 [P] [US6] Implement `CountryListItem` in `lib/features/settings/presentation/widgets/country_list_item.dart` (alphabetical list row with country name).
- [X] T028 [P] [US6] Implement `CountrySelectionPage` in `lib/features/settings/presentation/pages/country_selection_page.dart` (Screen 95: active country highlight card with blue checkmark, search input bar with magnifying glass, and alphabetical country list).
- [X] T029 [P] [US6] Implement `LanguageSelectionPage` in `lib/features/settings/presentation/pages/language_selection_page.dart` (Screen 96: 6 language option tiles via `PreferenceOptionTile`).
- [X] T030 [P] [US6] Implement `CurrencySelectionPage` in `lib/features/settings/presentation/pages/currency_selection_page.dart` (Screen 97: $ USD and € EURO tiles via `PreferenceOptionTile`).
- [X] T031 [P] [US6] Implement `SizesSelectionPage` in `lib/features/settings/presentation/pages/sizes_selection_page.dart` (Screen 98: US, EU, and UK tiles via `PreferenceOptionTile`).

**Checkpoint**: User Story 6 complete and independently verifiable.

---

## Phase 9: User Story 7 (P3) — Delete Account + About (Screens 99, 100)

**Goal**: Deliver the Delete Account safety warning modal and the About ShopX brand heritage page.  
**Independent Test**: Tap Delete My Account to open Screen 99 modal dialog; test Cancel and Delete; navigate to `/settings/about` to view Screen 100 with radial glow, logo, and email.

- [X] T032 [P] [US7] Implement `DeleteAccountDialog` in `lib/features/settings/presentation/widgets/delete_account_dialog.dart` (Screen 99: centered modal with 28.r radius, circular warning badge in `AppColors.deleteWarningBg` with exclamation mark, warning copy, Cancel black pill, and Delete red pill).
- [X] T033 [P] [US7] Implement `AboutShopXPage` in `lib/features/settings/presentation/pages/about_shopx_page.dart` (Screen 100: top radial blue glow via `AppColors.aboutGlow`, centered ShopX blue shopping bag logo `assets/images/ShopX_logo.png`, descriptive text, and contact email `contact.blacksidedesign@gmail.com`).
- [X] T034 [US7] Wire `DeleteAccountDialog.show(context)` trigger on `Delete My Account` button in `SettingsPage` and handle confirmation in `SettingsCubit` in `lib/features/settings/presentation/pages/settings_page.dart`.

**Checkpoint**: User Story 7 complete; all 15 screens (86 to 100) implemented and fully functional.

---

## Phase 10: Polish & Cross-Cutting Concerns

**Purpose**: Improvements, code formatting, static analysis, and automated widget tests. Run strictly once at the end.

- [X] T035 [P] Add unit and widget tests for Settings, Payment, Shipping, and Preferences in `test/features/settings/`.
- [X] T036 Execute code formatting and run `fvm flutter analyze` strictly once to verify 0 errors and 0 warnings across the codebase.

---

## Phase 11: Convergence

**Purpose**: Address convergence finding where the settings gear icon in `ProfileHeader`, `ProfilePage`, and `OrdersHeader` was navigating to chat or unhandled rather than the settings hub.

- [X] T037 Connect settings gear icon in `ProfileHeader` (`lib/features/profile/presentation/widgets/profile_header.dart`), `ProfilePage` (`lib/features/profile/presentation/pages/profile_page.dart`), and `OrdersHeader` (`lib/features/orders/presentation/widgets/orders_header.dart`) to `RouteNames.kSettingsPage` per US1 (missing)

---

## Dependencies & Execution Order

### Phase Dependencies
- **Phase 1 (Setup & Tokens)**: No dependencies — must execute first to register tokens and directories.
- **Phase 2 (Foundational)**: Depends on Phase 1 — BLOCKS all user stories.
- **Phases 3–9 (User Stories US1–US7)**: Depend on Phase 2 completion. Can proceed sequentially (US1 → US2 → US3 → US4 → US5 → US6 → US7) or in parallel.
- **Phase 10 (Polish)**: Depends on all user stories being complete.

### Implementation Strategy
1. **MVP Scope**: Complete Phase 1 (Tokens), Phase 2 (Foundational), and Phase 3 (US1 — Settings Main). This delivers a functioning settings hub mounted on the Profile tab.
2. **Incremental Delivery**:
   - Add US2 (Profile Credentials)
   - Add US3 & US4 (Payment Methods, History, and Add/Edit Card)
   - Add US5 (Shipping Address)
   - Add US6 (Preferences)
   - Add US7 (Delete Account & About ShopX)
3. **Verification**: Run `fvm flutter analyze` only in Phase 10.

