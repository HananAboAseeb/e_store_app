import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/home_data_entity.dart';
import '../../domain/entities/wishlist_item_entity.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

class WishlistLoaded extends WishlistState {
  final List<WishlistItemEntity> items;
  final String? message;

  const WishlistLoaded({
    required this.items,
    this.message,
  });

  WishlistLoaded copyWith({
    List<WishlistItemEntity>? items,
    String? message,
  }) {
    return WishlistLoaded(
      items: items ?? this.items,
      message: message,
    );
  }

  @override
  List<Object?> get props => [items, message];
}

class WishlistEmpty extends WishlistState {
  final List<HomeProductEntity> popularProducts;

  const WishlistEmpty({
    required this.popularProducts,
  });

  @override
  List<Object?> get props => [popularProducts];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}
