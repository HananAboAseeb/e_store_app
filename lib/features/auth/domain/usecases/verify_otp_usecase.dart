import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpParams extends Equatable {
  final String email;
  final String otpCode;

  const VerifyOtpParams({
    required this.email,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [email, otpCode];
}

class VerifyOtpUseCase implements UseCase<UserEntity, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call([VerifyOtpParams? param]) {
    return repository.verifyOtp(
      email: param?.email ?? '',
      otpCode: param?.otpCode ?? '',
    );
  }
}
