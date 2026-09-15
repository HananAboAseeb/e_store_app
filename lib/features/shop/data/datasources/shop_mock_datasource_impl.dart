import '../models/shop_category_model.dart';
import '../models/shop_product_model.dart';
import 'shop_mock_datasource.dart';

class ShopMockDataSourceImpl implements ShopMockDataSource {
  @override
  Future<List<ShopProductModel>> getProducts() async {
    // Simulated realistic network latency
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();

    return [
      ShopProductModel(
        id: 'shop_1',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_1.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'T-shirts',
        sizes: const ['S', 'M', 'L', 'XL'],
        colors: const ['white', 'blue', 'black'],
        isPopular: true,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      ShopProductModel(
        id: 'shop_2',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_2.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'T-shirts',
        sizes: const ['XS', 'S', 'M'],
        colors: const ['gray', 'white'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      ShopProductModel(
        id: 'shop_3',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_3.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'Shirts',
        sizes: const ['S', 'M', 'L'],
        colors: const ['white', 'blue'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      ShopProductModel(
        id: 'shop_4',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_4.png',
        price: 17.00,
        category: 'Clothing',
        subCategory: 'Shirts',
        sizes: const ['M', 'L', 'XL'],
        colors: const ['black', 'gray'],
        isPopular: true,
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      ShopProductModel(
        id: 'shop_5',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_5.png',
        price: 16.00,
        originalPrice: 20.00,
        isDiscounted: true,
        category: 'Clothing',
        subCategory: 'Tunics',
        sizes: const ['S', 'M', 'L', 'XL'],
        colors: const ['camel', 'white'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      ShopProductModel(
        id: 'shop_6',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/prod_20_6.png',
        price: 17.00,
        originalPrice: 20.00,
        isDiscounted: true,
        category: 'Clothing',
        subCategory: 'Shirts',
        sizes: const ['M', 'L', 'XL', '2XL'],
        colors: const ['black'],
        isPopular: true,
        createdAt: now.subtract(const Duration(days: 6)),
      ),
      ShopProductModel(
        id: 'shop_7',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_1.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'Hoodies',
        sizes: const ['S', 'M', 'L'],
        colors: const ['black', 'gray'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      ShopProductModel(
        id: 'shop_8',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_2.png',
        price: 17.00,
        category: 'Clothing',
        subCategory: 'Hoodies',
        sizes: const ['XS', 'S', 'M', 'L'],
        colors: const ['black'],
        isPopular: true,
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      ShopProductModel(
        id: 'shop_9',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_3.png',
        price: 16.00,
        originalPrice: 20.00,
        isDiscounted: true,
        category: 'Clothing',
        subCategory: 'Jackets',
        sizes: const ['M', 'L', 'XL'],
        colors: const ['blue', 'black'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 9)),
      ),
      ShopProductModel(
        id: 'shop_10',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_4.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'Dresses',
        sizes: const ['XS', 'S', 'M'],
        colors: const ['red', 'black'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      ShopProductModel(
        id: 'shop_11',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_5.png',
        price: 17.00,
        originalPrice: 20.00,
        isDiscounted: true,
        category: 'Clothing',
        subCategory: 'Pants',
        sizes: const ['S', 'M', 'L', 'XL'],
        colors: const ['black', 'gray', 'blue'],
        isPopular: true,
        createdAt: now.subtract(const Duration(days: 11)),
      ),
      ShopProductModel(
        id: 'shop_12',
        title: 'Lorem ipsum dolor sit amet consectetur',
        imageUrl: 'assets/images/home_flash_6.png',
        price: 16.00,
        category: 'Clothing',
        subCategory: 'Skirts',
        sizes: const ['XS', 'S', 'M'],
        colors: const ['white', 'blue'],
        isPopular: false,
        createdAt: now.subtract(const Duration(days: 12)),
      ),
    ];
  }

  @override
  Future<List<ShopCategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return const [
      ShopCategoryModel(
        id: 'cat_dresses',
        name: 'Dresses',
        assetPath: 'assets/images/cat_cloth_1.png',
      ),
      ShopCategoryModel(
        id: 'cat_pants',
        name: 'Pants',
        assetPath: 'assets/images/cat_cloth_2.png',
      ),
      ShopCategoryModel(
        id: 'cat_skirts',
        name: 'Skirts',
        assetPath: 'assets/images/cat_cloth_1.png',
      ),
      ShopCategoryModel(
        id: 'cat_tunics',
        name: 'Tunics',
        assetPath: 'assets/images/cat_cloth_2.png',
      ),
      ShopCategoryModel(
        id: 'cat_jackets',
        name: 'Jackets',
        assetPath: 'assets/images/jact.png',
      ),
      ShopCategoryModel(
        id: 'cat_hoodies',
        name: 'Hoodies',
        assetPath: 'assets/images/cat_hoodie_1.png',
      ),
      ShopCategoryModel(
        id: 'cat_shirts',
        name: 'Shirts',
        assetPath: 'assets/images/cat_cloth_1.png',
      ),
      ShopCategoryModel(
        id: 'cat_polo',
        name: 'Polo',
        assetPath: 'assets/images/cat_cloth_2.png',
      ),
      ShopCategoryModel(
        id: 'cat_tshirts',
        name: 'T-shirts',
        assetPath: 'assets/images/cat_cloth_1.png',
      ),
    ];
  }
}
