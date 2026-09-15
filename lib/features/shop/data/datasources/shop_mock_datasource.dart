import '../models/shop_category_model.dart';
import '../models/shop_product_model.dart';

abstract class ShopMockDataSource {
  Future<List<ShopProductModel>> getProducts();
  Future<List<ShopCategoryModel>> getCategories();
}
