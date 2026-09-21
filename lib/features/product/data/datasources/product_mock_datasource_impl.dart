import '../../../shop/data/models/shop_product_model.dart';
import '../models/delivery_option_model.dart';
import '../models/product_details_model.dart';
import '../models/product_variant_model.dart';
import '../models/rating_breakdown_model.dart';
import '../models/review_model.dart';
import '../models/specification_model.dart';
import 'product_mock_datasource.dart';

class ProductMockDataSourceImpl implements ProductMockDataSource {
  final List<ReviewModel> _allReviews = [
    const ReviewModel(
      id: 'rev_1',
      authorName: 'Veronica',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 4.0,
      text:
          'Lorem ipsum dolor sit amet, consectetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.',
      likes: 24,
      dislikes: 24,
      timeAgo: '2 Days Ago',
    ),
    const ReviewModel(
      id: 'rev_2',
      authorName: 'Jessica Smith',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 5.0,
      text:
          'Amazing leather jacket! Fits like a glove and the color matches the pictures perfectly. Fast delivery too.',
      likes: 42,
      dislikes: 2,
      timeAgo: '4 Days Ago',
    ),
    const ReviewModel(
      id: 'rev_3',
      authorName: 'Amanda Clark',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 4.5,
      text:
          'Quality is top notch, genuine feel and great craftsmanship. Worth every dollar during the flash sale.',
      likes: 19,
      dislikes: 1,
      timeAgo: '1 Week Ago',
    ),
    const ReviewModel(
      id: 'rev_4',
      authorName: 'Sophia Miller',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 4.0,
      text:
          'Ordered size M, fits perfectly. The nylon lining makes it comfortable to wear for hours.',
      likes: 12,
      dislikes: 0,
      timeAgo: '2 Weeks Ago',
    ),
    const ReviewModel(
      id: 'rev_5',
      authorName: 'Elena Rostova',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 5.0,
      text:
          'Beautiful styling and very warm. Got lots of compliments from friends!',
      likes: 31,
      dislikes: 3,
      timeAgo: '3 Weeks Ago',
    ),
    const ReviewModel(
      id: 'rev_6',
      authorName: 'Chloe Bennett',
      authorAvatar: 'assets/images/profile_picture.png',
      rating: 4.0,
      text:
          'Express delivery took only 2 days as promised. Excellent customer service.',
      likes: 8,
      dislikes: 0,
      timeAgo: '1 Month Ago',
    ),
  ];

  @override
  Future<ProductDetailsModel> getProductDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return ProductDetailsModel(
      id: id.isNotEmpty ? id : 'caviar-jacket',
      title: 'Caviar Leather Jacket',
      breadcrumb: const ['Shop', 'Jackets', 'Caviar'],
      rating: 4.7,
      reviewCount: 2986,
      scoreCount: 3654,
      basePrice: 24.00,
      salePrice: 17.00,
      discountPercent: 20,
      isFlashSale: true,
      // 36 minutes and 58 seconds -> 2218 seconds (matching Screen 35: 00:36:58)
      flashSaleRemainingSeconds: 2218,
      variants: const [
        ProductVariantModel(
          id: 'v_red',
          name: 'Dark Red',
          colorHex: '#8B0000',
          thumbnailUrl: 'assets/images/girl_image.png',
          images: [
            'assets/images/jact.png',
            'assets/images/girl_image.png',
          ],
        ),
        ProductVariantModel(
          id: 'v_purple',
          name: 'Purple',
          colorHex: '#3A00CC',
          thumbnailUrl: 'assets/images/home_flash_2.png',
          images: [
            'assets/images/home_flash_2.png',
            'assets/images/girl_image.png',
          ],
        ),
        ProductVariantModel(
          id: 'v_green',
          name: 'Green',
          colorHex: '#00A859',
          thumbnailUrl: 'assets/images/home_flash_3.png',
          images: [
            'assets/images/home_flash_3.png',
            'assets/images/girl_image.png',
          ],
        ),
      ],
      availableSizes: const ['XS', 'S', 'M', 'L', 'XL', '2XL'],
      specifications: const [
        SpecificationModel(
          label: 'Material',
          values: ['Cotton: 95%', 'Nylon: 5%'],
        ),
        SpecificationModel(
          label: 'Origin',
          values: ['EUROPE'],
        ),
      ],
      deliveryOptions: const [
        DeliveryOptionModel(
          id: 'del_std',
          name: 'Standard',
          estimatedDays: '5 - 7 Days',
          price: 3.00,
        ),
        DeliveryOptionModel(
          id: 'del_exp',
          name: 'Express',
          estimatedDays: '1 - 2 Days',
          price: 12.00,
        ),
      ],
      ratingsBreakdown: const [
        RatingBreakdownModel(stars: 5, percentage: 0.20),
        RatingBreakdownModel(stars: 4, percentage: 0.20),
        RatingBreakdownModel(stars: 3, percentage: 0.20),
        RatingBreakdownModel(stars: 2, percentage: 0.20),
        RatingBreakdownModel(stars: 1, percentage: 0.20),
      ],
      reviewsPreview: _allReviews.take(2).toList(),
      mostPopularProducts: [
        ShopProductModel(
          id: 'mp_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/cat_cloth_1.png',
          price: 17.80,
          originalPrice: null,
          isDiscounted: false,
          category: 'Clothing',
          subCategory: 'Jackets',
          sizes: const ['S', 'M', 'L'],
          colors: const ['#1A1A1A'],
          isPopular: true,
          createdAt: DateTime.now(),
        ),
        ShopProductModel(
          id: 'mp_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_2.png',
          price: 17.80,
          originalPrice: 22.00,
          isDiscounted: true,
          category: 'Clothing',
          subCategory: 'Jackets',
          sizes: const ['M', 'L'],
          colors: const ['#FF3B30'],
          isPopular: true,
          createdAt: DateTime.now(),
        ),
        ShopProductModel(
          id: 'mp_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_6.png',
          price: 17.80,
          originalPrice: null,
          isDiscounted: false,
          category: 'Clothing',
          subCategory: 'Jackets',
          sizes: const ['S', 'M'],
          colors: const ['#004BFE'],
          isPopular: true,
          createdAt: DateTime.now(),
        ),
      ],
      youMightLikeProducts: [
        ShopProductModel(
          id: 'yml_1',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 16.00,
          originalPrice: 20.00,
          isDiscounted: true,
          category: 'Clothing',
          subCategory: 'T-Shirts',
          sizes: const ['S', 'M', 'L'],
          colors: const ['#004BFE'],
          isPopular: true,
          createdAt: DateTime.now(),
        ),
        ShopProductModel(
          id: 'yml_2',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_2.png',
          price: 17.00,
          originalPrice: null,
          isDiscounted: false,
          category: 'Clothing',
          subCategory: 'T-Shirts',
          sizes: const ['M', 'L'],
          colors: const ['#1A1A1A'],
          isPopular: false,
          createdAt: DateTime.now(),
        ),
        ShopProductModel(
          id: 'yml_3',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_3.png',
          price: 16.00,
          originalPrice: 20.00,
          isDiscounted: true,
          category: 'Clothing',
          subCategory: 'Dresses',
          sizes: const ['S', 'M'],
          colors: const ['#FF3B30'],
          isPopular: true,
          createdAt: DateTime.now(),
        ),
        ShopProductModel(
          id: 'yml_4',
          title: 'Lorem ipsum dolor sit amet consectetur',
          imageUrl: 'assets/images/prod_20_5.png',
          price: 17.00,
          originalPrice: null,
          isDiscounted: false,
          category: 'Clothing',
          subCategory: 'Pants',
          sizes: const ['M', 'L'],
          colors: const ['#FF9500'],
          isPopular: false,
          createdAt: DateTime.now(),
        ),
      ],
    );
  }

  @override
  Future<List<ReviewModel>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final startIndex = (page - 1) * limit;
    if (startIndex >= _allReviews.length) {
      return [];
    }
    return _allReviews.skip(startIndex).take(limit).toList();
  }

  @override
  Future<ReviewModel> voteReview(String reviewId,
      {required bool isLike}) async {
    await Future.delayed(const Duration(milliseconds: 80));
    final index = _allReviews.indexWhere((r) => r.id == reviewId);
    if (index == -1) {
      throw Exception('Review not found');
    }
    final existing = _allReviews[index];
    int newLikes = existing.likes;
    int newDislikes = existing.dislikes;
    bool? newVote;

    if (existing.userVote == isLike) {
      // Toggle off
      newVote = null;
      if (isLike) newLikes--;
      if (!isLike) newDislikes--;
    } else {
      // Switch or new vote
      if (existing.userVote == true) newLikes--;
      if (existing.userVote == false) newDislikes--;

      newVote = isLike;
      if (isLike) newLikes++;
      if (!isLike) newDislikes++;
    }

    final updated = existing.copyWith(
      likes: newLikes,
      dislikes: newDislikes,
      userVote: () => newVote,
    );
    _allReviews[index] = ReviewModel.fromEntity(updated);
    return _allReviews[index];
  }
}
