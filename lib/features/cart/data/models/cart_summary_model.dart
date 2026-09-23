import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/cart_summary_entity.dart';
import 'cart_item_model.dart';
import 'shipping_address_model.dart';

class CartSummaryModel extends CartSummaryEntity {
  const CartSummaryModel({
    required super.items,
    required super.wishlistSuggestions,
    required super.popularSuggestions,
    super.shippingAddress,
  });

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      wishlistSuggestions: (json['wishlistSuggestions'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      popularSuggestions: (json['popularSuggestions'] as List<dynamic>?)
              ?.map((e) => ShopProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shippingAddress: json['shippingAddress'] != null
          ? ShippingAddressModel.fromJson(
              json['shippingAddress'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => CartItemModel.fromEntity(e).toJson()).toList(),
      'wishlistSuggestions': wishlistSuggestions
          .map((e) => CartItemModel.fromEntity(e).toJson())
          .toList(),
      'popularSuggestions': popularSuggestions
          .map((e) => (e is ShopProductModel
                  ? e
                  : ShopProductModel(
                      id: e.id,
                      title: e.title,
                      imageUrl: e.imageUrl,
                      price: e.price,
                      originalPrice: e.originalPrice,
                      isDiscounted: e.isDiscounted,
                      category: e.category,
                      subCategory: e.subCategory,
                      sizes: e.sizes,
                      colors: e.colors,
                      isPopular: e.isPopular,
                      createdAt: e.createdAt,
                    ))
              .toJson())
          .toList(),
      'shippingAddress': shippingAddress != null
          ? ShippingAddressModel.fromEntity(shippingAddress!).toJson()
          : null,
    };
  }

  factory CartSummaryModel.fromEntity(CartSummaryEntity entity) {
    return CartSummaryModel(
      items: entity.items,
      wishlistSuggestions: entity.wishlistSuggestions,
      popularSuggestions: entity.popularSuggestions,
      shippingAddress: entity.shippingAddress,
    );
  }

  CartSummaryEntity toEntity() {
    return CartSummaryEntity(
      items: items,
      wishlistSuggestions: wishlistSuggestions,
      popularSuggestions: popularSuggestions,
      shippingAddress: shippingAddress,
    );
  }
}
