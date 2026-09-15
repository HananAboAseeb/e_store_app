import '../../domain/entities/shop_category_entity.dart';

class ShopCategoryModel extends ShopCategoryEntity {
  const ShopCategoryModel({
    required super.id,
    required super.name,
    required super.assetPath,
    super.isSelected,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      assetPath: json['assetPath'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assetPath': assetPath,
      'isSelected': isSelected,
    };
  }
}
