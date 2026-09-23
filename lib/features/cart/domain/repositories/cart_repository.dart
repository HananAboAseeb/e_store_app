import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cart_item_entity.dart';
import '../entities/cart_summary_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartSummaryEntity>> getCart();
  Future<Either<Failure, CartSummaryEntity>> addItem(CartItemEntity item);
  Future<Either<Failure, CartSummaryEntity>> removeItem(String itemId);
  Future<Either<Failure, CartSummaryEntity>> updateQuantity(
      String itemId, int quantity);
  Future<Either<Failure, CartSummaryEntity>> removeWishlistSuggestion(
      String itemId);
  Future<Either<Failure, CartSummaryEntity>> clearCart();
}
