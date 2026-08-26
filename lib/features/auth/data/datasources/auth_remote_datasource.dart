import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String phoneNumber);
  Future<UserModel> verifyOtp(String email, String otpCode);
  Future<bool> forgotPassword(String email, String method);
  Future<UserModel> resetPassword(
      String email, String newPassword, String confirmPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Option to inject ApiConsumer if needed in Phase 2 live migration
  final dynamic apiConsumer;

  AuthRemoteDataSourceImpl([this.apiConsumer]);

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (email == 'error@shopx.com' || password == 'error') {
      throw Exception('Invalid credentials. Please check your email or password.');
    }
    return UserModel.mock(email: email);
  }

  @override
  Future<UserModel> register(
      String email, String password, String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (email == 'error@shopx.com') {
      throw Exception('Email address is already in use.');
    }
    return UserModel.mock(email: email, phone: phoneNumber);
  }

  @override
  Future<UserModel> verifyOtp(String email, String otpCode) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (otpCode == '0000') {
      throw Exception('Invalid verification code. Please try again.');
    }
    return UserModel.mock(email: email);
  }

  @override
  Future<bool> forgotPassword(String email, String method) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (email == 'error@shopx.com') {
      throw Exception('Account not found with provided email.');
    }
    return true;
  }

  @override
  Future<UserModel> resetPassword(
      String email, String newPassword, String confirmPassword) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (newPassword != confirmPassword) {
      throw Exception('Passwords do not match.');
    }
    return UserModel.mock(email: email);
  }
}
