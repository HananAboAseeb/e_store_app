import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/story_entity.dart';
import '../repositories/profile_repository.dart';

class GetStoriesUseCase implements UseCase<List<StoryEntity>, NoParam> {
  final ProfileRepository repository;

  GetStoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<StoryEntity>>> call([NoParam? param]) =>
      repository.getStories();
}
