import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return await safeCall(() => remoteDataSource.login(email, password));
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    return await safeCall(
        () => remoteDataSource.register(email, password, phoneNumber));
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    return await safeCall(() => remoteDataSource.verifyOtp(email, otpCode));
  }

  @override
  Future<Either<Failure, bool>> forgotPassword({
    required String email,
    required String method,
  }) async {
    return await safeCall(() => remoteDataSource.forgotPassword(email, method));
  }

  @override
  Future<Either<Failure, UserEntity>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await safeCall(
      () => remoteDataSource.resetPassword(email, newPassword, confirmPassword),
    );
  }
}
