# Feature Specification: Settings & User Account Management (Screens 86–100)

**Feature Directory**: `specs/015-settings`

**Feature Branch**: `015-settings`

**Created**: 2026-11-05

**Status**: Ready for Planning

**Input**: User description: "Settings feature covering Screens 86–100: Settings Main (Screens 86, 87), Your Profile (Screen 88), Payment Methods & History (Screens 89, 92), Add/Edit Card Sheets (Screens 90, 91), Shipping Address View/Edit (Screens 93, 94), Preferences (Country 95, Language 96, Currency 97, Sizes 98), Delete Account Warning Modal (Screen 99), and About ShopX (Screen 100)"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Settings Navigation Hub & Section Hierarchy (Screens 86, 87) (Priority: P1)

As an authenticated customer, I want to view a comprehensive Settings hub partitioned into Personal, Shop, and Account categories with immediate route access and app version branding, so that I can configure my account, shopping preferences, and payment information effortlessly.

**Why this priority**: The Settings screen is the master entry hub for all account management, legal agreements, regional settings, and payment configurations. It is mounted on the Profile tab of the persistent bottom navigation shell.

**Independent Test**: Can be tested independently by navigating to `/settings`, verifying all 3 sections (Personal, Shop, Account), checking items and trailing metadata labels ("Iran", "$ USD", "UK", "English"), tapping "Delete My Account" to trigger the deletion alert dialog, verifying app version branding, and tapping each row to verify correct route navigation.

**Acceptance Scenarios**:

1. **Given** an authenticated user navigating to `/settings`, **When** the page renders, **Then** they see:
   - A bold header `Settings` (`headlineLarge`, black).
   - **Personal Section**: Header `Personal` above a rounded grey container (`AppColors.surfaceContainer`, 16.r radius) containing:
     - `Profile` with a subtle trailing grey chevron.
     - Horizontal hairline divider (`AppColors.divider`).
     - `Shipping Address` with trailing chevron.
     - Horizontal hairline divider.
     - `Payment Methods` with trailing chevron.
   - **Shop Section**: Header `Shop` above a rounded grey container (16.r radius) containing:
     - `Country` with subtitle/metadata `Iran` in grey + chevron.
     - Divider.
     - `Currency` with subtitle/metadata `$ USD` in grey + chevron.
     - Divider.
     - `Sizes` with subtitle/metadata `UK` in grey + chevron.
     - Divider.
     - `Terms and Conditions` with chevron.
   - **Account Section** (Screen 87): Header `Account` above a rounded grey container (16.r radius) containing:
     - `Language` with subtitle/metadata `English` in grey + chevron.
     - Divider.
     - `About ShopX` with chevron.
   - **Delete My Account Button**: Full-width rounded card (16.r radius) with a soft blush/pink background (`AppColors.deleteAccountBg`), red bold text `Delete My Account` (`AppColors.error`), and trailing red chevron.
   - **Version Footer**: Left-aligned branding text showing `ShopX` (bold, 16.sp) and `Version 1.0 June, 2026` (`AppColors.textSecondary`, 12.sp).
   - **Bottom Navigation**: Persistent `CustomBottomNavBar` with the Profile tab active (`NavEnum.profile`).
2. **Given** Screen 86/87, **When** the user taps any menu row (Profile, Shipping Address, Payment Methods, Country, Currency, Sizes, Language, About ShopX), **Then** the application navigates via `go_router` to the respective dedicated route.
3. **Given** Screen 87, **When** the user taps `Delete My Account`, **Then** the `DeleteAccountDialog` modal dialog (Screen 99) is displayed.

---

### User Story 2 - User Profile Inspection & Account Credentials (Screen 88) (Priority: P2)

As a user, I want to inspect my profile picture, username, email address, and masked password, and initiate credential edits, so that I can maintain my account identity and verify my registration details.

**Why this priority**: Profile transparency allows users to review their account credentials and initiate security updates.

**Independent Test**: Can be tested independently by navigating to `/settings/profile`, verifying the avatar thumbnail, checking formatted text fields for Username ("Romina"), Email Address ("gmail@example.com"), and Password ("***************"), and tapping "Edit Information".

**Acceptance Scenarios**:

1. **Given** the user navigates to `/settings/profile`, **When** the screen renders, **Then** they see:
   - Top header with bold title `Settings` and subtitle `Your Profile`.
   - Circular profile avatar (80.w x 80.h) with white border outline and soft shadow, displaying the user's portrait (`assets/images/profile_picture.png`).
   - `Username` field group: label `Username` above a soft blue-tinted container (`AppColors.primarySoft`, 12.r radius, 52.h) displaying `Romina` in bold black text.
   - `Email Address` field group: label `Email Address` above a soft blue container displaying `gmail@example.com`.
   - `Password` field group: label `Password` above a soft blue container displaying masked bullet characters (`***************`).
   - Bottom full-width rounded button: `Edit Information` with light grey background (`AppColors.surfaceOption`, 28.r radius) and bold black text.
2. **Given** the profile screen, **When** the user taps `Edit Information`, **Then** the fields toggle into an editable mode or prompt for password re-authentication.

---

### User Story 3 - Payment Methods Management & Transaction History (Screens 89, 90, 91, 92) (Priority: P1)

As a shopper, I want to manage my credit/debit cards, toggle between card view and payment transaction history, add new payment cards via a modal sheet, and edit existing card details, so that my checkout transactions proceed without payment friction.

**Why this priority**: Payment configuration directly drives conversion and post-purchase settlement. Without payment cards, checkout cannot be completed.

**Independent Test**: Can be tested independently by navigating to `/settings/payment`, swiping the card carousel (Mastercard and Visa), tapping the History toggle icon to switch between PayPal/empty state (Screen 89) and Payment History (Screen 92), tapping the `+` button to open Add Card sheet (Screen 90), tapping the card gear icon to open Edit Card sheet (Screen 91), and saving modifications.

**Acceptance Scenarios**:

1. **Given** the user navigates to `/settings/payment`, **When** rendered in default card mode (Screen 89), **Then**:
   - Header shows `Settings` and subtitle `Payment Methods`.
   - Section header `Card` with two circular action buttons on the right:
     - History button: circular grey button (`AppColors.surfaceAnnouncement`) with clock/history icon (`Icons.history`).
     - Add card button: circular grey button with plus `+` icon (`Icons.add`).
   - Horizontal card carousel displaying saved payment cards:
     - Mastercard card: pastel blue container (`AppColors.primarySoft`, 16.r radius), Mastercard interlocking circles logo, white circular badge with blue gear icon (`Icons.settings_outlined`), masked card number `* * * *   * * * *   * * * *   1579`, cardholder `AMANDA`, expiry `12/22`.
     - Visa card: soft blush container (`AppColors.blushSoft`), navy italic `VISA` logo, masked number, cardholder `AMANDA`.
   - `PayPal` section below carousel:
     - Title `PayPal` with right-aligned circular `+` button.
     - Row displaying circular blue PayPal icon (`AppColors.paypalBlue`, diameter 44.r) and text `There is no account yet`.
2. **Given** Screen 89, **When** the user taps the circular History button, **Then**:
   - The screen transitions to Screen 92 (*Payment Methods + History*).
   - The History circular button becomes highlighted with a solid blue background (`AppColors.primary`) and white icon.
   - The PayPal section is replaced by the `Payment History` section displaying chronological transaction records:
     - Transaction 1: light grey card (`AppColors.surfaceContainer`), blue shopping bag icon (`AppColors.historyCreditIcon`), date `April,19 2020 12:31`, `Order #92287157`, amount `-$14,00` in black bold text.
     - Transaction 2: light grey card, blue bag, date, `Order #92287157`, amount `-$21,00`.
     - Transaction 3: soft pink card (`AppColors.historyDebitCardBg`), coral red bag icon (`AppColors.historyDebitIcon`), date, `Order #92287157`, amount `-$37,00` in coral red bold text (`AppColors.discount`).
     - Transaction 4: light grey card, blue bag, date, `Order #92287157`, amount `-$14,00`.
3. **Given** the Payment Methods screen, **When** the user taps the circular `+` button in the Card section, **Then** the `Add Card` modal bottom sheet (Screen 90) opens:
   - Header: bold title `Add Card` and right-aligned `ModalCloseButton` (`✕`).
   - Form fields in soft blue rounded containers (`AppColors.primarySoft`):
     - `Card Holder` with placeholder `Required`.
     - `Card Number` with placeholder `Required`.
     - Side-by-side row: `Expiration Date` (left) and `CVV` (right), both with placeholder `Required`.
   - Full-width blue `PrimaryButton` with text `Save Changes`.
4. **Given** the Payment Methods screen, **When** the user taps the gear settings icon on any card (e.g., Mastercard), **Then** the `Edit Card` modal bottom sheet (Screen 91) opens:
   - Header: bold title `Edit Card` and `ModalCloseButton`.
   - Pre-filled fields:
     - `Card Holder`: `Romina Black`.
     - `Card Number`: `**** **** **** 1579`.
     - `Expiration Date`: `12 / 28`.
     - `CVV`: `676`.
   - Full-width blue `PrimaryButton` with text `Save Changes`.
5. **Given** the Add/Edit Card modal, **When** valid card information is entered and `Save Changes` is tapped, **Then** the card is updated/saved in the repository, a success indicator is displayed, and the modal closes.

---

### User Story 4 - Shipping Address View & Edit Lifecycle (Screens 93, 94) (Priority: P2)

As a customer, I want to review my delivery address details in a clean read-only view and toggle into an editable view with country selection, so that my parcels are delivered to my exact postal destination.

**Why this priority**: Shipping accuracy ensures timely package fulfillment without delivery exceptions or misrouted orders.

**Independent Test**: Can be tested independently by navigating to `/settings/shipping`, inspecting address fields in read-only state (Screen 93), tapping "Edit Information", confirming transition to edit state with active Save Changes button (Screen 94), modifying fields, and saving.

**Acceptance Scenarios**:

1. **Given** the user navigates to `/settings/shipping`, **When** rendered in read-only mode (Screen 93), **Then**:
   - Header shows bold title `Settings` and subtitle `Shipping address`.
   - Country picker row: rounded grey container (`AppColors.surfaceContainer`, 16.r radius) with a blue globe icon (`Icons.language`), top label `Country` in grey, value `Choose your country` (or selected country name), and trailing chevron.
   - Form field groups (labels above soft blue-tinted containers):
     - `Address`: `110 W 44th Street, NY 10036`.
     - `Town / City`: `New York`.
     - `Postcode`: `10012`.
     - `Phone Number`: `+98*******22`.
   - Bottom full-width button: `Edit Information` with grey background (`AppColors.surfaceOption`, 28.r radius) and bold black text.
2. **Given** Screen 93, **When** the user taps `Edit Information`, **Then**:
   - The view enters editable mode (Screen 94).
   - The Country card displays the active selection (e.g., `Iran`).
   - The input fields become interactive.
   - The bottom button becomes a blue `PrimaryButton` with text `Save Changes`.
3. **Given** Screen 94, **When** the user edits the address fields and taps `Save Changes`, **Then** the updated address is persisted, a success SnackBar confirms the update, and the screen reverts to read-only mode.

---

### User Story 5 - Regional & Shopping Preferences (Screens 95, 96, 97, 98) (Priority: P2)

As an international customer, I want to select my country, preferred language, display currency, and sizing standards from intuitive selection lists with clear active indicators, so that the e-commerce store adapts to my regional context.

**Why this priority**: Regional settings customize pricing, sizing fit, and localized language across the shopping journey.

**Independent Test**: Can be tested independently by navigating to `/settings/country`, searching and selecting a country (Screen 95); navigating to `/settings/language` and choosing a language option (Screen 96); selecting a currency (Screen 97); and selecting standard sizes (Screen 98).

**Acceptance Scenarios**:

1. **Given** the user navigates to `/settings/country`, **When** rendered (Screen 95), **Then**:
   - Header shows `Settings` and subtitle `Country`.
   - Top active country card: soft blue background (`AppColors.primarySoft`, 16.r radius), bold text `Iran`, and right-aligned blue checkmark circle (`Icons.check_circle`, `AppColors.primary`).
   - Search input bar: rounded grey pill (`AppColors.surfaceContainer`, 16.r radius) with magnifying glass icon and placeholder `Search between countries`.
   - Alphabetical scrollable country list: Afghanistan, Albania, Algeria, Andorra, Angola, Antigua and Barbuda, Argentina, Armenia, Aruba, Australia, etc.
   - Tapping any country updates the active country selection and returns to the previous screen.
2. **Given** the user navigates to `/settings/language`, **When** rendered (Screen 96), **Then**:
   - Header shows `Settings` and subtitle `Language`.
   - Vertical option pills (16.r radius, 54.h height, 12.h spacing):
     - `English`: active item with soft blue background (`AppColors.primarySoft`), bold black text, and right-aligned blue checkmark circle.
     - Inactive items: `Français`, `中文`, `Español`, `Русский`, `فارسی` with soft grey background (`AppColors.surfaceAnnouncement`) and bold black text.
   - Tapping any language option immediately sets it as active, updates the checkmark indicator, and applies the locale.
3. **Given** the user navigates to `/settings/currency`, **When** rendered (Screen 97), **Then**:
   - Header shows `Settings` and subtitle `Currency`.
   - Two option pills:
     - `$ USD`: active item with soft blue background and blue checkmark circle.
     - `€ EURO`: unselected item with soft grey background.
   - Tapping an option switches active currency.
4. **Given** the user navigates to `/settings/sizes`, **When** rendered (Screen 98), **Then**:
   - Header shows `Settings` and subtitle `Sizes`.
   - Three option pills:
     - `US`: active item with soft blue background and blue checkmark circle.
     - `EU`: unselected item with soft grey background.
     - `UK`: unselected item with soft grey background.
   - Tapping an option switches the active sizing standard.

---

### User Story 6 - Account Deletion Safety Dialog (Screens 87, 99) (Priority: P3)

As a customer desiring to remove my profile, I want a high-visibility confirmation dialog with clear warnings before permanently deleting my account data, so that accidental account removal is prevented.

**Why this priority**: Account deletion is a destructive, irreversible action requiring explicit confirmation to avoid accidental data loss.

**Independent Test**: Can be tested independently by tapping "Delete My Account" on Screen 87, verifying the modal dialog (Screen 99), confirming warning message, testing the "Cancel" dismiss action, and testing the "Delete" action.

**Acceptance Scenarios**:

1. **Given** Screen 87, **When** the user taps `Delete My Account`, **Then** the `DeleteAccountDialog` (Screen 99) appears centered over a blurred/dimmed backdrop:
   - Centered white card container (28.r radius, 24.w padding).
   - Centered circular grey warning badge (`AppColors.surfaceAnnouncement`, 64.r diameter) with a grey exclamation point icon (`!`).
   - Title: `You are going to delete your account` (bold, 18.sp, black, center-aligned).
   - Subtitle: `You won't be able to restore your data` (`AppColors.textSecondary`, 14.sp, center-aligned).
   - Action buttons row with two side-by-side pill buttons:
     - Left: `Cancel` (solid black background `AppColors.black`, white bold text, 26.r radius, 50.h height).
     - Right: `Delete` (solid red background `AppColors.error`, white bold text, 26.r radius, 50.h height).
2. **Given** Screen 99, **When** the user taps `Cancel`, **Then** the dialog dismisses and the user remains on the Settings screen.
3. **Given** Screen 99, **When** the user taps `Delete`, **Then** the deletion usecase executes, the auth session is cleared, and the user is redirected to the login/onboarding screen with a confirmation message.

---

### User Story 7 - About ShopX Brand Heritage & Support Outreach (Screen 100) (Priority: P3)

As a user exploring the app's pedigree, I want to view the ShopX background story and developer contact information, so that I can learn about the application origin and reach out for assistance.

**Why this priority**: Brand credibility, support outreach, and UI kit licensing information build stakeholder confidence.

**Independent Test**: Can be tested independently by navigating to `/settings/about`, verifying the top radial blue glow, ShopX bag logo, description text, and clickable contact email.

**Acceptance Scenarios**:

1. **Given** the user navigates to `/settings/about`, **When** rendered (Screen 100), **Then**:
   - Top background features a soft radial blue glow (`AppColors.aboutGlow`, fading gently to white).
   - Centered ShopX blue shopping bag logo (`assets/images/ShopX_logo.png` or `assets/images/ShopX.png`, 120.w x 120.h).
   - Title: `About ShopX` (bold, 24.sp, black, left-aligned).
   - Description text: *"ShopX - Shopping UI kit is a user interface (UI) kit designed to facilitate the development of e-commerce or shopping-related applications. UI kits are collections of pre-designed elements, components, and templates that developers and designers can use to create consistent and visually appealing user interfaces."* in body typography.
   - Spacing divider.
   - Help text: *"If you need help or you have any questions, feel free to contact me by email."*
   - Contact email: `contact.blacksidedesign@gmail.com` in bold black text.
   - Bottom navigation: Profile tab active.
2. **Given** Screen 100, **When** the user taps the email address, **Then** an external mailto prompt is initiated or the email is copied to the clipboard with feedback.

---

### Edge Cases

- **Empty Payment Cards**: When no payment cards exist, the card carousel shows a subtle "Add your first card" placeholder card, keeping the `+` button fully functional.
- **Empty Payment History**: When the transaction list has no records, a polite `NoDataFoundWidget` or "No transactions yet" message is displayed in place of the transaction rows.
- **Country Search with Zero Matches**: When search query in Screen 95 matches no countries, a clean "No countries found" message appears while retaining the top active country card.
- **Invalid Card Inputs**: In Add/Edit Card sheets (Screens 90, 91), if card holder, number, expiration date, or CVV are missing or malformed, field-level validation highlights missing inputs before allowing submission.
- **Rapid Toggle of History Button**: Tapping the history button repeatedly switches smoothly between card view and history list without visual stutter or duplicate state emissions.
- **Account Deletion Failure**: If account deletion encounters a network error, a descriptive error SnackBar is displayed and the account remains intact.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST render the Settings hub (Screens 86, 87) organized into three structured containers: `Personal`, `Shop`, and `Account`.
- **FR-002**: System MUST render navigation rows with title, optional trailing metadata value, and right-pointing chevrons.
- **FR-003**: System MUST provide a distinct `Delete My Account` button styled with a soft pink background and red accent typography on Screen 87.
- **FR-004**: System MUST display the application name `ShopX` and version string `Version 1.0 June, 2026` at the bottom of the Settings main page.
- **FR-005**: System MUST display user profile data (avatar, username, email, masked password) on Screen 88.
- **FR-006**: System MUST support viewing saved credit/debit cards in a horizontal carousel on Screen 89/92 with distinct Mastercard and Visa visual stylings.
- **FR-007**: System MUST provide a circular History toggle button that toggles between PayPal placeholder (Screen 89) and Payment History transaction list (Screen 92).
- **FR-008**: System MUST display color-coded transaction cards in Payment History: light grey cards with blue bag icons for standard transactions, and soft pink cards with coral red bag icons and text for debit/special transactions.
- **FR-009**: System MUST present an `Add Card` bottom sheet modal (Screen 90) with fields for Card Holder, Card Number, Expiration Date, CVV, and a `Save Changes` button.
- **FR-010**: System MUST present an `Edit Card` bottom sheet modal (Screen 91) pre-populated with existing card parameters.
- **FR-011**: System MUST render the shipping address in a read-only presentation (Screen 93) with an `Edit Information` trigger.
- **FR-012**: System MUST allow full editing of shipping address fields (Country, Address, Town/City, Postcode, Phone Number) with a `Save Changes` button (Screen 94).
- **FR-013**: System MUST display an alphabetical list of countries with search filtering and an active country highlight card (Screen 95).
- **FR-014**: System MUST display language options (`English`, `Français`, `中文`, `Español`, `Русский`, `فارسی`) with a blue checkmark indicator on the active language (Screen 96).
- **FR-015**: System MUST display currency options (`$ USD`, `€ EURO`) with active checkmark styling (Screen 97).
- **FR-016**: System MUST display clothing/shoe sizing options (`US`, `EU`, `UK`) with active checkmark styling (Screen 98).
- **FR-017**: System MUST display a confirmation dialog for account deletion (Screen 99) with warning icon, explanatory text, `Cancel` black pill button, and `Delete` red pill button.
- **FR-018**: System MUST render the `About ShopX` screen (Screen 100) with radial blue background glow, blue shopping bag logo, app description, and support email.
- **FR-019**: System MUST maintain the persistent bottom navigation bar (`CustomBottomNavBar`) on primary top-level settings screens with the Profile tab highlighted.
- **FR-020**: System MUST execute all state management via 5 specialized Cubits (`SettingsCubit`, `AccountCubit`, `PaymentSettingsCubit`, `ShippingSettingsCubit`, `PreferencesCubit`) extending `Equatable`.
- **FR-021**: System MUST load initial data through mock data sources with simulated network delays and shimmer placeholder states.
- **FR-022**: System MUST navigate between screens using `go_router` declarative routes under `/settings`.
- **FR-023**: System MUST use `safeCall` in repository implementations to map exceptions into typed `Failure` objects returning `Either<Failure, T>`.

---

### Key Entities *(include if feature involves data)*

- **SettingsMenuItemEntity**: Represents an individual navigation entry in the settings menus. Attributes: `id`, `title`, `subtitle`, `icon`, `routePath`, `section`.
- **UserAccountEntity**: Represents user credentials and profile state. Attributes: `id`, `username`, `email`, `passwordMasked`, `avatarUrl`.
- **PaymentCardEntity**: Represents a customer payment card. Attributes: `id`, `cardBrand` (Mastercard, Visa), `cardholderName`, `maskedCardNumber`, `expirationDate`, `cvv`, `isDefault`.
- **PaymentHistoryEntity**: Represents a settled payment transaction. Attributes: `id`, `orderNumber`, `transactionDate`, `amount`, `isDebit`, `iconType`.
- **ShippingAddressEntity**: Represents customer shipping address parameters. Attributes: `id`, `country`, `addressLine`, `city`, `postcode`, `phoneNumber`.
- **CountryEntity**: Represents a selectable country. Attributes: `id`, `name`, `code`, `flagUrl`.
- **LanguageEntity**: Represents a selectable application language. Attributes: `id`, `name`, `nativeName`, `localeCode`, `isSelected`.
- **CurrencyEntity**: Represents an application display currency. Attributes: `id`, `code`, `symbol`, `name`, `isSelected`.
- **SizeStandardEntity**: Represents a regional apparel sizing standard. Attributes: `id`, `label`, `region`, `isSelected`.

---

## Visual Specifications & Design Token Mapping

| Screen ID & Name | Elements & Tokens | Exact Colors & Values | Figma Screenshot Reference |
|---|---|---|---|
| **86 / 87: Settings Main** | • Header: `Settings`<br>• Sections: `Personal`, `Shop`, `Account`<br>• Menu Containers: `AppContainer`<br>• Delete Button: `AppColors.deleteAccountBg`<br>• Version: `ShopX` + `Version 1.0 June, 2026`<br>• Bottom Nav: Profile active | • Background: `AppColors.white`<br>• Containers: `AppColors.surfaceContainer` (`#F8F8F8`), 16.r<br>• Delete Button: `#FFEBEB`, text `#FF3B30`<br>• Dividers: `AppColors.divider`, 1.h<br>• Title: `AppTypography.h1`, black | `assets/design_references/86 SETTINGS.png`<br>`assets/design_references/87 SETTINGS FULL.png` |
| **88: Your Profile** | • Avatar: 80.w x 80.h circle<br>• Fields: Username, Email, Password<br>• Value Containers: Soft blue tint<br>• Action: `Edit Information` button | • Avatar: `assets/images/profile_picture.png`<br>• Value fill: `AppColors.primarySoft` (`#EAF0FF`), 12.r<br>• Button: `AppColors.surfaceOption` (`#E6E6E6`), text black, 28.r | `assets/design_references/88 SETTINGS PROFILE.png` |
| **89 / 92: Payment Methods** | • Header: `Payment Methods`<br>• Card Section: History ↺ & Add + buttons<br>• Carousel: Mastercard & Visa cards<br>• PayPal Section (89): Blue P icon + text<br>• History Section (92): 4 transaction cards | • Mastercard: `AppColors.primarySoft`, interlocking circles<br>• Visa: `AppColors.blushSoft`, navy italic VISA<br>• History active button: `AppColors.primary` (`#004BFE`), white icon<br>• Transaction credit: `#F8F8F8`, blue bag<br>• Transaction debit: `#FFF0F2`, red bag, `-$37,00` red | `assets/design_references/89 SETTINGS PAYMENT.png`<br>`assets/design_references/92 PAYMENT METHODS + HISTORY.png` |
| **90 / 91: Add/Edit Card** | • Bottom Sheet Modal (24.r top)<br>• Header: `Add Card` / `Edit Card` + ✕<br>• Inputs: Card Holder, Number, Expiry, CVV<br>• Action: `Save Changes` | • Sheet: `AppColors.surface`, top radius 24.r<br>• Input fields: `AppColors.primarySoft` (`#EAF0FF`), 12.r<br>• Close: `ModalCloseButton`<br>• Button: `PrimaryButton` (`AppColors.primary`, 28.r) | `assets/design_references/90 SETTINGS ADD CARD.png`<br>`assets/design_references/91 EDIT CARD.png` |
| **93 / 94: Shipping Address** | • Header: `Shipping address`<br>• Country row: Globe icon + Country name<br>• Fields: Address, Town/City, Postcode, Phone<br>• Button: `Edit Information` (93) / `Save Changes` (94) | • Globe icon: `AppColors.primary`, size 24.r<br>• Fields: `AppColors.primarySoft` (`#EAF0FF`), 12.r<br>• Button (93): `#E6E6E6` with black text<br>• Button (94): `AppColors.primary` with white text | `assets/design_references/93 SHIPPING ADDRESS.png`<br>`assets/design_references/94 EDIT SHIPPING ADDRESS.png` |
| **95: Settings Country** | • Selected Card: `Iran` + Checkmark<br>• Search: Pill with magnifying glass<br>• Country List: Alphabetical text list | • Selected Card: `AppColors.primarySoft`, checkmark `AppColors.primary`<br>• Search bar: `AppColors.surfaceContainer` (`#EFEFEF`), 16.r<br>• List items: `AppTypography.bodyMedium`, 46.h row | `assets/design_references/95 SETTINGS COUNTRY.png` |
| **96: Settings Language** | • Header: `Language`<br>• Option pills (6 languages)<br>• Active: `English` with checkmark | • Active: `AppColors.primarySoft`, checkmark `AppColors.primary`<br>• Inactive: `AppColors.surfaceAnnouncement` (`#EAEAEA`), 16.r, 54.h | `assets/design_references/96 SETTINGS LANGUAGE.png` |
| **97: Settings Currency** | • Header: `Currency`<br>• Option pills: `$ USD`, `€ EURO`<br>• Active: `$ USD` | • Active: `AppColors.primarySoft`, blue checkmark<br>• Inactive: `AppColors.surfaceAnnouncement`, 16.r, 54.h | `assets/design_references/97 SETTINGS CURRENCY.png` |
| **98: Settings Sizes** | • Header: `Sizes`<br>• Option pills: `US`, `EU`, `UK`<br>• Active: `US` | • Active: `AppColors.primarySoft`, blue checkmark<br>• Inactive: `AppColors.surfaceAnnouncement`, 16.r, 54.h | `assets/design_references/98 SETTINGS SIZES.png` |
| **99: Delete Account Warning** | • Centered Alert Dialog<br>• Exclamation badge: Circular grey badge<br>• Title & Subtitle warning text<br>• Actions: `Cancel` (black) & `Delete` (red) | • Dialog card: White, 28.r radius, 24.w padding<br>• Badge: `#EAEAEA`, 64.r diameter<br>• Cancel: `AppColors.black`, white text, 26.r<br>• Delete: `AppColors.error` (`#FF3B30`), white text, 26.r | `assets/design_references/99 SETTINGS DELETE ACCOUNT WARNING.png` |
| **100: About ShopX** | • Radial blue background glow<br>• Blue ShopX shopping bag logo<br>• Title: `About ShopX`<br>• Descriptive text & support email | • Glow: `AppColors.aboutGlow` (`#E1EDFF`), radial gradient<br>• Logo: `assets/images/ShopX_logo.png`, 120.w x 120.h<br>• Email: `AppTypography.bodyLarge`, bold black | `assets/design_references/100 ABOUT SHOPPE.png` |

---

## Widget Reuse & DRY Analysis

In strict compliance with the Permanent Project Rules, all existing shared and feature widgets have been audited before proposing new widgets:

### Existing Shared Widgets (Reused)
- **`CustomBottomNavBar`** (`lib/shared/navigation/`): Existing widget found — reusing it for persistent bottom navigation on primary settings screens.
- **`PrimaryButton`** (`lib/shared/widgets/`): Existing widget found — reusing it for `Save Changes` on Add/Edit Card sheets (90, 91) and Shipping Address (94).
- **`AppText`** (`lib/shared/widgets/`): Existing widget found — reusing it for section headers, page titles, and body labels.
- **`AppContainer`** (`lib/shared/widgets/`): Existing widget found — reusing it for menu section grouping containers.
- **`ModalCloseButton`** (`lib/shared/widgets/`): Existing widget found — reusing it for the `✕` close button on Add Card (90) and Edit Card (91) sheets.
- **`MetaPill`** (`lib/shared/widgets/`): Existing widget found — reusing it for metadata labels and tag chips where applicable.
- **`PaymentCardItem`** (`lib/features/payment/presentation/widgets/payment_card_item.dart`): Existing widget found — reusing it for Mastercard and Visa carousel card presentation (contains identical interlocking circles, VISA typography, gear icon, and token styling).

### New Specialized Widgets (Creating & Justifying)
- **`SettingsMenuItem`**: No existing widget found — creating new: displays row title, optional trailing value, and chevron right with ripple tap handling.
- **`SettingsSectionHeader`**: No existing widget found — creating new: renders standardized bold section headers (`Personal`, `Shop`, `Account`) with consistent vertical margin.
- **`PaymentHistoryRow`**: No existing widget found — creating new: renders transaction record with colored bag icon, order number, timestamp, and signed currency amount.
- **`PreferenceOptionTile`**: No existing widget found — creating new: renders interactive selection pills with soft blue/grey backgrounds and circular checkmark indicator.
- **`CountryListItem`**: No existing widget found — creating new: renders alphabetical country entries in search list.
- **`ShippingFieldGroup`**: No existing widget found — creating new: renders label above soft blue-tinted read-only or editable text container.
- **`DeleteAccountDialog`**: No existing widget found — creating new: modal dialog with warning icon, copy, and side-by-side Cancel/Delete pills.
- **`AddEditCardSheet`**: No existing widget found — creating new: bottom sheet modal handling card creation and modification.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can navigate from the Settings hub to any subordinate screen (Profile, Payment, Shipping, Country, Language, Currency, Sizes, About) in under 1 tap with zero transition lag (< 100ms).
- **SC-002**: 100% of the 15 Figma reference screens (86–100) match the design references pixel-by-pixel (color palette, spacing, typography, corner radii).
- **SC-003**: Switching between Payment Cards and Payment History executes immediately with instantaneous UI toggle response.
- **SC-004**: Users can complete adding or editing a payment card in under 30 seconds with complete field validation feedback.
- **SC-005**: 100% of user selections (Language, Currency, Sizes, Country) immediately update visual state indicators and persist across screen reloads.
- **SC-006**: Codebase achieves 0 static analysis errors and 0 warnings under `flutter analyze`.

---

## Assumptions

- **Mock Data Scope**: All initial data (user profile, cards, addresses, country lists, transaction histories) will be served via mock data sources during Phase 1.
- **Language Localization**: Selecting language options (Screen 96) updates the app language preference state; mock translations cover existing English and Arabic strings.
- **Account Deletion Mock**: Triggering account deletion in Phase 1 executes a mock delay, displays a success notification, and redirects to the onboarding/login route.
- **Persistent Shell Mounting**: Settings is accessible as the primary view for `NavEnum.profile` tab in the persistent bottom navigation shell.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
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

