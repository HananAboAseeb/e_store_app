import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordParams({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [email, newPassword, confirmPassword];
}

class ResetPasswordUseCase implements UseCase<UserEntity, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call([ResetPasswordParams? param]) {
    return repository.resetPassword(
      email: param?.email ?? '',
      newPassword: param?.newPassword ?? '',
      confirmPassword: param?.confirmPassword ?? '',
    );
  }
}
