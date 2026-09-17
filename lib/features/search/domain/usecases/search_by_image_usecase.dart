import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/image_search_result_entity.dart';
import '../repositories/search_repository.dart';

class SearchByImageUseCase implements UseCase<ImageSearchResultEntity, String> {
  final SearchRepository repository;

  SearchByImageUseCase(this.repository);

  @override
  Future<Either<Failure, ImageSearchResultEntity>> call([String? param]) {
    return repository.searchByImage(param ?? '');
  }
}
