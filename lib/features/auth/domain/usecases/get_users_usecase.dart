import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUsersUseCase
    implements UseCase<List<UserEntity>, NoParam> {
  final AuthRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      [NoParam? param]) async {
    return repository.getUsers();
  }
}
