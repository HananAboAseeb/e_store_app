import '../../domain/entities/flash_sale_data_entity.dart';
import 'flash_sale_product_model.dart';
import 'live_stream_model.dart';

class FlashSaleDataModel extends FlashSaleDataEntity {
  const FlashSaleDataModel({
    required super.products,
    required super.liveStream,
    required super.popularProducts,
    super.countdownDuration,
  });

  factory FlashSaleDataModel.fromJson(Map<String, dynamic> json) {
    return FlashSaleDataModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => FlashSaleProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      liveStream: LiveStreamModel.fromJson(
        json['liveStream'] as Map<String, dynamic>,
      ),
      popularProducts: (json['popularProducts'] as List<dynamic>)
          .map((e) => FlashSaleProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      countdownDuration: json['countdownSeconds'] != null
          ? Duration(seconds: json['countdownSeconds'] as int)
          : const Duration(hours: 0, minutes: 36, seconds: 58),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products
          .map((e) => (e is FlashSaleProductModel ? e : FlashSaleProductModel(
                id: e.id,
                title: e.title,
                currentPrice: e.currentPrice,
                originalPrice: e.originalPrice,
                imageUrl: e.imageUrl,
                discountPercentage: e.discountPercentage,
                likeCount: e.likeCount,
                tag: e.tag,
              )).toJson())
          .toList(),
      'liveStream': (liveStream is LiveStreamModel
              ? liveStream as LiveStreamModel
              : LiveStreamModel(
                  id: liveStream.id,
                  title: liveStream.title,
                  bannerUrl: liveStream.bannerUrl,
                  isLive: liveStream.isLive,
                  viewerCount: liveStream.viewerCount,
                ))
          .toJson(),
      'popularProducts': popularProducts
          .map((e) => (e is FlashSaleProductModel ? e : FlashSaleProductModel(
                id: e.id,
                title: e.title,
                currentPrice: e.currentPrice,
                originalPrice: e.originalPrice,
                imageUrl: e.imageUrl,
                discountPercentage: e.discountPercentage,
                likeCount: e.likeCount,
                tag: e.tag,
              )).toJson())
          .toList(),
      'countdownSeconds': countdownDuration.inSeconds,
    };
  }
}
