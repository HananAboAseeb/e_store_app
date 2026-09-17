import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/search_data_entity.dart';
import '../repositories/search_repository.dart';

class GetSearchDataUseCase implements UseCase<SearchDataEntity, NoParam> {
  final SearchRepository repository;

  GetSearchDataUseCase(this.repository);

  @override
  Future<Either<Failure, SearchDataEntity>> call([NoParam? param]) {
    return repository.getSearchData();
  }
}
