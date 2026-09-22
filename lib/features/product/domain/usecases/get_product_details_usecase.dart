import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/product_details_entity.dart';
import '../repositories/product_repository.dart';

class GetProductDetailsUseCase extends UseCase<ProductDetailsEntity, String> {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsEntity>> call([String? param]) {
    return repository.getProductDetails(param ?? '');
  }
}
