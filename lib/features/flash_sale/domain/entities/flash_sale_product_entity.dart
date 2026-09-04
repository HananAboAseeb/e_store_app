import 'package:equatable/equatable.dart';

class FlashSaleProductEntity extends Equatable {
  final String id;
  final String title;
  final double currentPrice;
  final double originalPrice;
  final String imageUrl;
  final int discountPercentage;
  final int? likeCount;
  final String? tag;

  const FlashSaleProductEntity({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.originalPrice,
    required this.imageUrl,
    required this.discountPercentage,
    this.likeCount,
    this.tag,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        currentPrice,
        originalPrice,
        imageUrl,
        discountPercentage,
        likeCount,
        tag,
      ];
}
