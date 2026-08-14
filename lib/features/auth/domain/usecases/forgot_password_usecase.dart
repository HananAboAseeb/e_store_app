import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordParams extends Equatable {
  final String email;
  final String method; // 'sms' or 'email'

  const ForgotPasswordParams({
    required this.email,
    required this.method,
  });

  @override
  List<Object?> get props => [email, method];
}

class ForgotPasswordUseCase implements UseCase<bool, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call([ForgotPasswordParams? param]) {
    return repository.forgotPassword(
      email: param?.email ?? '',
      method: param?.method ?? 'email',
    );
  }
}
