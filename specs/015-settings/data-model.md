# Data Model: Settings & User Account Management (Screens 86–100)

**Feature**: `specs/015-settings`  
**Date**: 2026-11-05  
**Status**: Completed  

---

## 1. Domain Entities (`lib/features/settings/domain/entities/`)

### `UserAccountEntity`
Represents the user's profile and credentials (Screen 88).
```dart
class UserAccountEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String passwordMasked;
  final String avatarUrl;

  const UserAccountEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordMasked,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, username, email, passwordMasked, avatarUrl];
}
```

### `PaymentCardEntity`
Represents customer credit/debit cards (Screens 89, 90, 91, 92).
```dart
enum CardType { mastercard, visa, other }

class PaymentCardEntity extends Equatable {
  final String id;
  final CardType cardBrand;
  final String cardholderName;
  final String maskedCardNumber;
  final String expirationDate;
  final String cvv;
  final bool isDefault;

  const PaymentCardEntity({
    required this.id,
    required this.cardBrand,
    required this.cardholderName,
    required this.maskedCardNumber,
    required this.expirationDate,
    required this.cvv,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        id,
        cardBrand,
        cardholderName,
        maskedCardNumber,
        expirationDate,
        cvv,
        isDefault,
      ];
}
```

### `PaymentHistoryEntity`
Represents a settled transaction in the payment history list (Screen 92).
```dart
class PaymentHistoryEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String transactionDate;
  final double amount;
  final bool isDebit;

  const PaymentHistoryEntity({
    required this.id,
    required this.orderNumber,
    required this.transactionDate,
    required this.amount,
    required this.isDebit,
  });

  String get formattedAmount => '-$${amount.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  List<Object?> get props => [id, orderNumber, transactionDate, amount, isDebit];
}
```

### `ShippingAddressEntity`
Represents the customer delivery address (Screens 93, 94).
```dart
class ShippingAddressEntity extends Equatable {
  final String id;
  final String country;
  final String addressLine;
  final String city;
  final String postcode;
  final String phoneNumber;

  const ShippingAddressEntity({
    required this.id,
    required this.country,
    required this.addressLine,
    required this.city,
    required this.postcode,
    required this.phoneNumber,
  });

  ShippingAddressEntity copyWith({
    String? id,
    String? country,
    String? addressLine,
    String? city,
    String? postcode,
    String? phoneNumber,
  }) {
    return ShippingAddressEntity(
      id: id ?? this.id,
      country: country ?? this.country,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [id, country, addressLine, city, postcode, phoneNumber];
}
```

### `CountryEntity`
Represents a selectable country (Screen 95).
```dart
class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String code;
  final bool isSelected;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.code,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, name, code, isSelected];
}
```

### `LanguageEntity`
Represents a selectable application language (Screen 96).
```dart
class LanguageEntity extends Equatable {
  final String id;
  final String name;
  final String nativeName;
  final String localeCode;
  final bool isSelected;

  const LanguageEntity({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.localeCode,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, name, nativeName, localeCode, isSelected];
}
```

### `CurrencyEntity`
Represents a selectable display currency (Screen 97).
```dart
class CurrencyEntity extends Equatable {
  final String id;
  final String code;
  final String symbol;
  final String label; // e.g. "$ USD", "€ EURO"
  final bool isSelected;

  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.symbol,
    required this.label,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, code, symbol, label, isSelected];
}
```

### `SizeStandardEntity`
Represents an apparel sizing standard (Screen 98).
```dart
class SizeStandardEntity extends Equatable {
  final String id;
  final String label; // "US", "EU", "UK"
  final bool isSelected;

  const SizeStandardEntity({
    required this.id,
    required this.label,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, label, isSelected];
}
```

---

## 2. Data Models (`lib/features/settings/data/models/`)

Each domain entity has a corresponding model with JSON serialization / factory constructors:
- `UserAccountModel`
- `PaymentCardModel`
- `PaymentHistoryModel`
- `ShippingAddressModel`
- `CountryModel`
- `LanguageModel`
- `CurrencyModel`
- `SizeStandardModel`

---

## 3. Cubit State Hierarchy

### `SettingsState` (`SettingsCubit`)
```dart
enum SettingsStatus { initial, loading, loaded, failure, accountDeleted }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final String appVersion;
  final String? errorMessage;
  ...
}
```

### `AccountState` (`AccountCubit`)
```dart
enum AccountStatus { initial, loading, loaded, updating, updateSuccess, failure }

class AccountState extends Equatable {
  final AccountStatus status;
  final UserAccountEntity? userProfile;
  final String? errorMessage;
  ...
}
```

### `PaymentSettingsState` (`PaymentSettingsCubit`)
```dart
enum PaymentSettingsStatus { initial, loading, loaded, processing, success, failure }
enum PaymentViewMode { cards, history }

class PaymentSettingsState extends Equatable {
  final PaymentSettingsStatus status;
  final PaymentViewMode viewMode;
  final List<PaymentCardEntity> cards;
  final List<PaymentHistoryEntity> history;
  final String? errorMessage;
  ...
}
```

### `ShippingSettingsState` (`ShippingSettingsCubit`)
```dart
enum ShippingSettingsStatus { initial, loading, loaded, saving, saveSuccess, failure }

class ShippingSettingsState extends Equatable {
  final ShippingSettingsStatus status;
  final ShippingAddressEntity? address;
  final bool isEditing;
  final String? errorMessage;
  ...
}
```

### `PreferencesState` (`PreferencesCubit`)
```dart
enum PreferencesStatus { initial, loading, loaded, updated, failure }

class PreferencesState extends Equatable {
  final PreferencesStatus status;
  final List<CountryEntity> countries;
  final CountryEntity? selectedCountry;
  final String searchQuery;
  final List<LanguageEntity> languages;
  final LanguageEntity? selectedLanguage;
  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selectedCurrency;
  final List<SizeStandardEntity> sizes;
  final SizeStandardEntity? selectedSize;
  final String? errorMessage;
  ...
}
```

