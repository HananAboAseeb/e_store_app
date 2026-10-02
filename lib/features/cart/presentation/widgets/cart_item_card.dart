import 'package:flutter/material.dart';

import '../../../../shared/widgets/product_item_row.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'quantity_control.dart';

/// Cart item card that delegates presentation layout to the shared [ProductItemRow].
class CartItemCard extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProductItemRow(
      imageUrl: item.imageUrl,
      title: item.title,
      price: item.totalPrice,
      color: item.color,
      size: item.size,
      onDelete: onDelete,
      onTap: onTap,
      isWishlistLayout: false,
      trailingAction: QuantityControl(
        quantity: item.quantity,
        onIncrement: onIncrement,
        onDecrement: onDecrement,
      ),
    );
  }
}
