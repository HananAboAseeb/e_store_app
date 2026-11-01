import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/announcement_entity.dart';
import '../repositories/profile_repository.dart';

class GetAnnouncementUseCase implements UseCase<AnnouncementEntity, NoParam> {
  final ProfileRepository repository;

  GetAnnouncementUseCase(this.repository);

  @override
  Future<Either<Failure, AnnouncementEntity>> call([NoParam? param]) =>
      repository.getAnnouncement();
}
