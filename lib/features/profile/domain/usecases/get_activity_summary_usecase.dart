import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/activity_summary_entity.dart';
import '../repositories/profile_repository.dart';

class GetActivitySummaryUseCase
    implements UseCase<ActivitySummaryEntity, String> {
  final ProfileRepository repository;

  GetActivitySummaryUseCase(this.repository);

  @override
  Future<Either<Failure, ActivitySummaryEntity>> call(
          [String month = 'April']) =>
      repository.getActivitySummary(month);
}
