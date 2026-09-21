import '../../domain/entities/product_variant_entity.dart';

class ProductVariantModel extends ProductVariantEntity {
  const ProductVariantModel({
    required super.id,
    required super.name,
    required super.colorHex,
    required super.thumbnailUrl,
    required super.images,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      colorHex: json['colorHex'] as String? ?? '#000000',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colorHex': colorHex,
      'thumbnailUrl': thumbnailUrl,
      'images': images,
    };
  }

  factory ProductVariantModel.fromEntity(ProductVariantEntity entity) {
    return ProductVariantModel(
      id: entity.id,
      name: entity.name,
      colorHex: entity.colorHex,
      thumbnailUrl: entity.thumbnailUrl,
      images: entity.images,
    );
  }
}
