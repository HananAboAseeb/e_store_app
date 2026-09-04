import 'package:equatable/equatable.dart';
import 'flash_sale_product_entity.dart';
import 'live_stream_entity.dart';

class FlashSaleDataEntity extends Equatable {
  final List<FlashSaleProductEntity> products;
  final LiveStreamEntity liveStream;
  final List<FlashSaleProductEntity> popularProducts;
  final Duration countdownDuration;

  const FlashSaleDataEntity({
    required this.products,
    required this.liveStream,
    required this.popularProducts,
    this.countdownDuration = const Duration(hours: 0, minutes: 36, seconds: 58),
  });

  @override
  List<Object?> get props => [
        products,
        liveStream,
        popularProducts,
        countdownDuration,
      ];
}
