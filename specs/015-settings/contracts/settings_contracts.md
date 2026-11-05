# Interface Contracts: Settings & User Account Management (Screens 86–100)

**Feature**: `specs/015-settings`  
**Date**: 2026-11-05  
**Status**: Completed  

---

## 1. Domain Repository Contract (`SettingsRepository`)

```dart
abstract class SettingsRepository {
  /// Fetches the authenticated user's account profile (Screen 88).
  Future<Either<Failure, UserAccountEntity>> getProfile();

  /// Updates profile information (username, email, password) (Screen 88).
  Future<Either<Failure, UserAccountEntity>> updateProfile(UserAccountEntity profile);

  /// Fetches saved payment cards for the carousel (Screens 89, 92).
  Future<Either<Failure, List<PaymentCardEntity>>> getPaymentCards();

  /// Adds a new payment card (Screen 90).
  Future<Either<Failure, PaymentCardEntity>> addPaymentCard(PaymentCardEntity card);

  /// Updates existing card parameters (Screen 91).
  Future<Either<Failure, PaymentCardEntity>> updatePaymentCard(PaymentCardEntity card);

  /// Fetches past payment transaction history (Screen 92).
  Future<Either<Failure, List<PaymentHistoryEntity>>> getPaymentHistory();

  /// Fetches customer shipping address (Screens 93, 94).
  Future<Either<Failure, ShippingAddressEntity>> getShippingAddress();

  /// Updates customer shipping address (Screen 94).
  Future<Either<Failure, ShippingAddressEntity>> updateShippingAddress(ShippingAddressEntity address);

  /// Fetches list of available countries (Screen 95).
  Future<Either<Failure, List<CountryEntity>>> getCountries();

  /// Fetches supported languages (Screen 96).
  Future<Either<Failure, List<LanguageEntity>>> getLanguages();

  /// Fetches supported currencies (Screen 97).
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();

  /// Fetches supported sizing standards (Screen 98).
  Future<Either<Failure, List<SizeStandardEntity>>> getSizes();

  /// Permanently deletes the user account (Screen 99).
  Future<Either<Failure, void>> deleteAccount();
}
```

---

## 2. Data Source Contract (`SettingsMockDataSource`)

```dart
abstract class SettingsMockDataSource {
  Future<UserAccountModel> getProfile();
  Future<UserAccountModel> updateProfile(UserAccountModel profile);
  Future<List<PaymentCardModel>> getPaymentCards();
  Future<PaymentCardModel> addPaymentCard(PaymentCardModel card);
  Future<PaymentCardModel> updatePaymentCard(PaymentCardModel card);
  Future<List<PaymentHistoryModel>> getPaymentHistory();
  Future<ShippingAddressModel> getShippingAddress();
  Future<ShippingAddressModel> updateShippingAddress(ShippingAddressModel address);
  Future<List<CountryModel>> getCountries();
  Future<List<LanguageModel>> getLanguages();
  Future<List<CurrencyModel>> getCurrencies();
  Future<List<SizeStandardModel>> getSizes();
  Future<void> deleteAccount();
}
```

---

## 3. UI Navigation & Sheet Contracts

### GoRouter Route Contracts

| Route Name | Path | Component | Shell Nav Tab | Description |
|---|---|---|---|---|
| `RouteNames.kSettingsPage` | `/settings` | `SettingsPage` | `NavEnum.profile` | Main Settings menu (Screens 86, 87) |
| `RouteNames.kSettingsProfilePage` | `/settings/profile` | `YourProfilePage` | `NavEnum.profile` | User Profile (Screen 88) |
| `RouteNames.kSettingsPaymentPage` | `/settings/payment` | `PaymentSettingsPage` | `NavEnum.profile` | Cards & History (Screens 89, 92) |
| `RouteNames.kSettingsShippingPage` | `/settings/shipping` | `ShippingAddressPage` | `NavEnum.profile` | Address View & Edit (Screens 93, 94) |
| `RouteNames.kSettingsCountryPage` | `/settings/country` | `CountrySelectionPage` | `NavEnum.profile` | Country Search & Select (Screen 95) |
| `RouteNames.kSettingsLanguagePage` | `/settings/language` | `LanguageSelectionPage` | `NavEnum.profile` | Language Select (Screen 96) |
| `RouteNames.kSettingsCurrencyPage` | `/settings/currency` | `CurrencySelectionPage` | `NavEnum.profile` | Currency Select (Screen 97) |
| `RouteNames.kSettingsSizesPage` | `/settings/sizes` | `SizesSelectionPage` | `NavEnum.profile` | Sizes Standard Select (Screen 98) |
| `RouteNames.kSettingsAboutPage` | `/settings/about` | `AboutShopXPage` | `NavEnum.profile` | About ShopX Info (Screen 100) |

### Modal Sheet Contracts

#### `AddEditCardSheet` (Screens 90, 91)
```dart
class AddEditCardSheet {
  static Future<PaymentCardEntity?> show(
    BuildContext context, {
    PaymentCardEntity? initialCard,
  }) {
    return showModalBottomSheet<PaymentCardEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditCardSheet(initialCard: initialCard),
    );
  }
}
```

#### `DeleteAccountDialog` (Screen 99)
```dart
class DeleteAccountDialog {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const DeleteAccountDialog(),
    );
  }
}
```

