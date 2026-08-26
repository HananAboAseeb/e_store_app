# Data Model: User Authentication (Auth) Flow

**Feature Branch**: `001-user-auth`  
**Date**: 2026-08-10  
**Spec**: [spec.md](file:///e:/e_store/e_store/specs/001-user-auth/spec.md)

---

## Domain Entities (`lib/features/auth/domain/entities/`)

### 1. `UserEntity`
Represents an authenticated or newly registered user in the application.

```dart
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? phoneNumber;
  final String? fullName;
  final String? avatarUrl;
  final String? token;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.fullName,
    this.avatarUrl,
    this.token,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [id, email, phoneNumber, fullName, avatarUrl, token, isVerified];
}
```

### 2. `CountryCodeEntity`
Represents country dropdown choices for phone number entry.

```dart
class CountryCodeEntity extends Equatable {
  final String countryName;
  final String dialCode; // e.g. "+1"
  final String flagEmoji; // e.g. "🇺🇸"

  const CountryCodeEntity({
    required this.countryName,
    required this.dialCode,
    required this.flagEmoji,
  });

  @override
  List<Object?> get props => [countryName, dialCode, flagEmoji];
}
```

---

## Data Models (`lib/features/auth/data/models/`)

### `UserModel`
Extends `UserEntity` and implements JSON serialization/deserialization.

```dart
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.phoneNumber,
    super.fullName,
    super.avatarUrl,
    super.token,
    super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      token: json['token'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'token': token,
      'is_verified': isVerified,
    };
  }
}
```

---

## UseCase Parameters (`lib/features/auth/domain/usecases/`)

1. **`LoginParams`**: `{ required String email, required String password }`
2. **`RegisterParams`**: `{ required String email, required String password, required String phoneNumber }`
3. **`VerifyOtpParams`**: `{ required String contactInfo, required String otpCode }`
4. **`ForgotPasswordParams`**: `{ required String contactInfo, required String channel }` // "sms" or "email"
5. **`ResetPasswordParams`**: `{ required String newPassword, required String confirmPassword }`
