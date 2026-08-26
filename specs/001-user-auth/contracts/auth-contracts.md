# Contracts & Interface Specifications: User Authentication (Auth)

**Feature Branch**: `001-user-auth`  
**Date**: 2026-08-10  
**Spec**: [spec.md](file:///e:/e_store/e_store/specs/001-user-auth/spec.md)

---

## 1. Domain Repository Contract (`AuthRepository`)

```dart
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<Either<Failure, UserEntity>> verifyOtp({
    required String contactInfo,
    required String otpCode,
  });

  Future<Either<Failure, bool>> forgotPassword({
    required String contactInfo,
    required String channel, // 'sms' | 'email'
  });

  Future<Either<Failure, bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });
}
```

---

## 2. Remote Data Source Contract (`AuthRemoteDataSource`)

```dart
abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String phoneNumber);
  Future<UserModel> verifyOtp(String contactInfo, String otpCode);
  Future<bool> forgotPassword(String contactInfo, String channel);
  Future<bool> resetPassword(String newPassword, String confirmPassword);
}
```

---

## 3. UI Component Contracts

### `PrimaryButton`
- **Props**: `String text`, `VoidCallback? onPressed`, `bool isLoading`, `bool isDisabled`, `double? width`, `double height = 56.h`

### `AuthTextField`
- **Props**: `String hintText`, `TextEditingController? controller`, `Widget? prefixIcon`, `bool isPassword`, `String? Function(String?)? validator`

### `PinInput`
- **Props**: `int length = 4`, `String code`, `PinBoxState state` (`default`, `active`, `success`, `error`)

### `NumericKeyboard`
- **Props**: `Function(String digit) onDigitTap`, `VoidCallback onBackspaceTap`
