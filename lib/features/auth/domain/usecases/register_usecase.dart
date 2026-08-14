import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String phoneNumber;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [email, password, phoneNumber];
}

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call([RegisterParams? param]) {
    return repository.register(
      email: param?.email ?? '',
      password: param?.password ?? '',
      phoneNumber: param?.phoneNumber ?? '',
    );
  }
}
