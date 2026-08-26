import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

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
    required String email,
    required String otpCode,
  });

  Future<Either<Failure, bool>> forgotPassword({
    required String email,
    required String method, // 'sms' or 'email'
  });

  Future<Either<Failure, UserEntity>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  });
}
