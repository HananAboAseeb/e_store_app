import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_account_entity.dart';
import '../repositories/settings_repository.dart';

class GetProfileUseCase implements UseCase<UserAccountEntity, NoParam> {
  final SettingsRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserAccountEntity>> call([NoParam? param]) =>
      repository.getProfile();
}
