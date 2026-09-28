import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../repositories/categories_repository.dart';

class GetJustForYouProductsUseCase
    extends UseCase<List<ShopProductEntity>, NoParam> {
  final CategoriesRepository repository;

  GetJustForYouProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call([NoParam? param]) {
    return repository.getJustForYouProducts();
  }
}
