import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../repositories/search_repository.dart';

class ClearSearchHistoryUseCase implements UseCase<Unit, NoParam> {
  final SearchRepository repository;

  ClearSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call([NoParam? param]) {
    return repository.clearSearchHistory();
  }
}
