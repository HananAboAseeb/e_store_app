import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/reward_milestone_entity.dart';
import '../repositories/profile_repository.dart';

class GetRewardsUseCase
    implements UseCase<List<RewardMilestoneEntity>, NoParam> {
  final ProfileRepository repository;

  GetRewardsUseCase(this.repository);

  @override
  Future<Either<Failure, List<RewardMilestoneEntity>>> call([NoParam? param]) =>
      repository.getRewards();
}
