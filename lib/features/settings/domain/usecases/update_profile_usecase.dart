import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_account_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateProfileUseCase
    implements UseCase<UserAccountEntity, UserAccountEntity> {
  final SettingsRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserAccountEntity>> call([UserAccountEntity? param]) =>
      repository.updateProfile(param!);
}
