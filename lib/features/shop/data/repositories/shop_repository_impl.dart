import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/filter_criteria_entity.dart';
import '../../domain/entities/shop_category_entity.dart';
import '../../domain/entities/shop_product_entity.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_mock_datasource.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopMockDataSource mockDataSource;

  ShopRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, List<ShopCategoryEntity>>> getCategories() async {
    return await safeCall(() => mockDataSource.getCategories());
  }

  @override
  Future<Either<Failure, List<ShopProductEntity>>> getProducts({
    FilterCriteriaEntity? criteria,
  }) async {
    return await safeCall(() async {
      final allProducts = await mockDataSource.getProducts();
      if (criteria == null) {
        return allProducts;
      }

      final filtered = allProducts.where((product) {
        // SubCategory / Category filter
        if (criteria.selectedSubCategories.isNotEmpty) {
          final matchesSubCategory = criteria.selectedSubCategories.any(
            (sc) =>
                sc.toLowerCase() == product.subCategory.toLowerCase() ||
                sc.toLowerCase() == product.category.toLowerCase(),
          );
          if (!matchesSubCategory) return false;
        }

        // Size filter
        if (criteria.selectedSize != null &&
            criteria.selectedSize!.isNotEmpty) {
          final matchesSize = product.sizes.any(
            (s) => s.toLowerCase() == criteria.selectedSize!.toLowerCase(),
          );
          if (!matchesSize) return false;
        }

        // Color filter
        if (criteria.selectedColor != null &&
            criteria.selectedColor!.isNotEmpty) {
          final matchesColor = product.colors.any(
            (c) => c.toLowerCase() == criteria.selectedColor!.toLowerCase(),
          );
          if (!matchesColor) return false;
        }

        // Price range
        if (product.price < criteria.minPrice ||
            product.price > criteria.maxPrice) {
          return false;
        }

        return true;
      }).toList();

      // Sort
      switch (criteria.sortOption) {
        case ShopSortOption.popular:
          filtered.sort((a, b) {
            if (a.isPopular && !b.isPopular) return -1;
            if (!a.isPopular && b.isPopular) return 1;
            return 0;
          });
          break;
        case ShopSortOption.newest:
          filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case ShopSortOption.priceHighToLow:
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
      }

      return filtered;
    });
  }
}
