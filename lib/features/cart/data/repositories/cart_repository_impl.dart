import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/cart_summary_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_mock_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartMockDataSource mockDataSource;

  CartRepositoryImpl(this.mockDataSource);

  @override
  Future<Either<Failure, CartSummaryEntity>> getCart() async {
    return await safeCall(() => mockDataSource.getCart());
  }

  @override
  Future<Either<Failure, CartSummaryEntity>> addItem(
      CartItemEntity item) async {
    return await safeCall(
      () => mockDataSource.addItem(CartItemModel.fromEntity(item)),
    );
  }

  @override
  Future<Either<Failure, CartSummaryEntity>> removeItem(String itemId) async {
    return await safeCall(() => mockDataSource.removeItem(itemId));
  }

  @override
  Future<Either<Failure, CartSummaryEntity>> updateQuantity(
      String itemId, int quantity) async {
    return await safeCall(
      () => mockDataSource.updateQuantity(itemId, quantity),
    );
  }

  @override
  Future<Either<Failure, CartSummaryEntity>> removeWishlistSuggestion(
      String itemId) async {
    return await safeCall(
      () => mockDataSource.removeWishlistSuggestion(itemId),
    );
  }

  @override
  Future<Either<Failure, CartSummaryEntity>> clearCart() async {
    return await safeCall(() => mockDataSource.clearCart());
  }
}
