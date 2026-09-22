import '../models/product_details_model.dart';
import '../models/review_model.dart';

abstract class ProductMockDataSource {
  Future<ProductDetailsModel> getProductDetails(String id);

  Future<List<ReviewModel>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 10,
  });

  Future<ReviewModel> voteReview(
    String reviewId, {
    required bool isLike,
  });
}
