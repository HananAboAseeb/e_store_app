import 'package:equatable/equatable.dart';

class ProductVariantEntity extends Equatable {
  final String id;
  final String name;
  final String colorHex;
  final String thumbnailUrl;
  final List<String> images;

  const ProductVariantEntity({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.thumbnailUrl,
    required this.images,
  });

  @override
  List<Object?> get props => [id, name, colorHex, thumbnailUrl, images];
}
