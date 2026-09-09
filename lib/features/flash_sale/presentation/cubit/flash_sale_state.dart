import 'package:equatable/equatable.dart';
import '../../domain/entities/flash_sale_product_entity.dart';
import '../../domain/entities/live_stream_entity.dart';

abstract class FlashSaleState extends Equatable {
  const FlashSaleState();

  @override
  List<Object?> get props => [];
}

class FlashSaleInitial extends FlashSaleState {
  const FlashSaleInitial();
}

class FlashSaleLoading extends FlashSaleState {
  const FlashSaleLoading();
}

class FlashSaleLoaded extends FlashSaleState {
  final List<FlashSaleProductEntity> allProducts;
  final List<FlashSaleProductEntity> filteredProducts;
  final int? selectedDiscount;
  final LiveStreamEntity liveStream;
  final List<FlashSaleProductEntity> popularProducts;
  final Duration countdownDuration;

  const FlashSaleLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.selectedDiscount = 20,
    required this.liveStream,
    required this.popularProducts,
    this.countdownDuration = const Duration(hours: 0, minutes: 36, seconds: 58),
  });

  FlashSaleLoaded copyWith({
    List<FlashSaleProductEntity>? allProducts,
    List<FlashSaleProductEntity>? filteredProducts,
    int? selectedDiscount,
    bool clearDiscount = false,
    LiveStreamEntity? liveStream,
    List<FlashSaleProductEntity>? popularProducts,
    Duration? countdownDuration,
  }) {
    return FlashSaleLoaded(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedDiscount:
          clearDiscount ? null : (selectedDiscount ?? this.selectedDiscount),
      liveStream: liveStream ?? this.liveStream,
      popularProducts: popularProducts ?? this.popularProducts,
      countdownDuration: countdownDuration ?? this.countdownDuration,
    );
  }

  @override
  List<Object?> get props => [
        allProducts,
        filteredProducts,
        selectedDiscount,
        liveStream,
        popularProducts,
        countdownDuration,
      ];
}

class FlashSaleError extends FlashSaleState {
  final String message;

  const FlashSaleError(this.message);

  @override
  List<Object?> get props => [message];
}
