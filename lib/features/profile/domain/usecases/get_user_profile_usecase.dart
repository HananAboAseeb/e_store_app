import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserProfileUseCase implements UseCase<UserProfileEntity, NoParam> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfileEntity>> call([NoParam? param]) =>
      repository.getUserProfile();
}
