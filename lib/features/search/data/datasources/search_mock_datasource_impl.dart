import '../../../shop/data/models/shop_product_model.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../models/image_search_result_model.dart';
import '../models/recommendation_model.dart';
import '../models/search_history_model.dart';
import 'search_mock_datasource.dart';

class SearchMockDataSourceImpl implements SearchMockDataSource {
  List<SearchHistoryModel> _history = [
    SearchHistoryModel(
      id: 'h1',
      query: 'Socks',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    SearchHistoryModel(
      id: 'h2',
      query: 'Red Dress',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    SearchHistoryModel(
      id: 'h3',
      query: 'Sunglasses',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    SearchHistoryModel(
      id: 'h4',
      query: 'Mustard Pants',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    SearchHistoryModel(
      id: 'h5',
      query: "80's Skirt",
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  final List<RecommendationModel> _recommendations = const [
    RecommendationModel(id: 'r1', label: 'Skirt'),
    RecommendationModel(id: 'r2', label: 'Accessories'),
    RecommendationModel(id: 'r3', label: 'Black T-Shirt'),
    RecommendationModel(id: 'r4', label: 'Jeans'),
    RecommendationModel(id: 'r5', label: 'White Shoes'),
  ];

  final List<ShopProductModel> _allProducts = [
    ShopProductModel(
      id: 'sp_1',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_1.png',
      price: 16.00,
      originalPrice: 20.00,
      isDiscounted: true,
      category: 'Clothing',
      subCategory: 'Socks',
      sizes: const ['S', 'M', 'L'],
      colors: const ['#1A1A1A', '#004BFE'],
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ShopProductModel(
      id: 'sp_2',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_2.png',
      price: 17.00,
      originalPrice: null,
      isDiscounted: false,
      category: 'Clothing',
      subCategory: 'Socks',
      sizes: const ['M', 'L', 'XL'],
      colors: const ['#FFFFFF', '#FF3B30'],
      isPopular: false,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    ShopProductModel(
      id: 'sp_3',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_3.png',
      price: 16.00,
      originalPrice: 20.00,
      isDiscounted: true,
      category: 'Clothing',
      subCategory: 'Red Dress',
      sizes: const ['S', 'M'],
      colors: const ['#FF3B30', '#004BFE'],
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ShopProductModel(
      id: 'sp_4',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_4.png',
      price: 17.00,
      originalPrice: null,
      isDiscounted: false,
      category: 'Accessories',
      subCategory: 'Sunglasses',
      sizes: const ['One Size'],
      colors: const ['#1A1A1A', '#C4C4C4'],
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    ShopProductModel(
      id: 'sp_5',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_5.png',
      price: 16.00,
      originalPrice: 20.00,
      isDiscounted: true,
      category: 'Clothing',
      subCategory: 'Mustard Pants',
      sizes: const ['M', 'L'],
      colors: const ['#FF9500', '#1A1A1A'],
      isPopular: false,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    ShopProductModel(
      id: 'sp_6',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_6.png',
      price: 17.00,
      originalPrice: null,
      isDiscounted: false,
      category: 'Clothing',
      subCategory: "80's Skirt",
      sizes: const ['S', 'M', 'L'],
      colors: const ['#004BFE', '#FF5790'],
      isPopular: true,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  @override
  Future<List<SearchHistoryModel>> getSearchHistory() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.from(_history);
  }

  @override
  Future<List<RecommendationModel>> getRecommendations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.from(_recommendations);
  }

  @override
  Future<List<ShopProductModel>> getDiscoverProducts() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _allProducts
        .map(
          (p) => ShopProductModel(
            id: p.id,
            title: p.title,
            imageUrl: p.imageUrl,
            price: 17.00,
            originalPrice: null,
            isDiscounted: false,
            category: p.category,
            subCategory: p.subCategory,
            sizes: p.sizes,
            colors: p.colors,
            isPopular: p.isPopular,
            createdAt: p.createdAt,
          ),
        )
        .toList();
  }

  @override
  Future<List<ShopProductModel>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final cleanQuery = query.trim().toLowerCase();

    List<ShopProductModel> results = _allProducts.where((p) {
      if (cleanQuery.isEmpty) return true;
      final matchTitle = p.title.toLowerCase().contains(cleanQuery);
      final matchSub = p.subCategory.toLowerCase().contains(cleanQuery);
      final matchCat = p.category.toLowerCase().contains(cleanQuery);
      return matchTitle || matchSub || matchCat;
    }).toList();

    // If no direct keyword match, provide fallback items for demo
    if (results.isEmpty) {
      results = List.from(_allProducts);
    }

    if (filter != null) {
      if (filter.selectedSubCategories.isNotEmpty) {
        results = results.where((p) {
          return filter.selectedSubCategories.any(
            (cat) =>
                cat.toLowerCase() == p.subCategory.toLowerCase() ||
                cat.toLowerCase() == p.category.toLowerCase(),
          );
        }).toList();
      }
      results = results
          .where(
              (p) => p.price >= filter.minPrice && p.price <= filter.maxPrice)
          .toList();

      final selectedSize = filter.selectedSize;
      if (selectedSize != null && selectedSize.isNotEmpty) {
        results = results.where((p) => p.sizes.contains(selectedSize)).toList();
      }

      final selectedColor = filter.selectedColor;
      if (selectedColor != null && selectedColor.isNotEmpty) {
        results =
            results.where((p) => p.colors.contains(selectedColor)).toList();
      }
    }

    return results;
  }

  @override
  Future<ImageSearchResultModel> searchByImage(String imagePath) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return ImageSearchResultModel(
      id: 'img_res_1',
      imagePath:
          imagePath.isNotEmpty ? imagePath : 'assets/images/cat_cloth_1.png',
      detectedCategory: 'Shoes',
      confidence: 0.94,
      products: _allProducts.take(4).toList(),
    );
  }

  @override
  Future<void> clearSearchHistory() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _history = [];
  }
}
