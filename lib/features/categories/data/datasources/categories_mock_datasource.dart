import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/gender_filter.dart';
import '../models/category_group_model.dart';

abstract class CategoriesMockDataSource {
  Future<List<CategoryGroupModel>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });

  Future<List<ShopProductModel>> getJustForYouProducts();
}
