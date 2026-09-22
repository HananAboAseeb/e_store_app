import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/product_variant_entity.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntity product;
  final int selectedVariantIndex;
  final String selectedSize;
  final bool isWishlisted;
  final int remainingSeconds;
  final bool isFlashSaleActive;

  const ProductDetailsLoaded({
    required this.product,
    required this.selectedVariantIndex,
    required this.selectedSize,
    required this.isWishlisted,
    required this.remainingSeconds,
    required this.isFlashSaleActive,
  });

  ProductVariantEntity get activeVariant => product.variants.isNotEmpty &&
          selectedVariantIndex < product.variants.length
      ? product.variants[selectedVariantIndex]
      : const ProductVariantEntity(
          id: '',
          name: '',
          colorHex: '#000000',
          thumbnailUrl: '',
          images: [],
        );

  List<String> get activeImages => activeVariant.images;

  double get currentPrice => isFlashSaleActive && product.salePrice != null
      ? product.salePrice!
      : product.basePrice;

  ProductDetailsLoaded copyWith({
    ProductDetailsEntity? product,
    int? selectedVariantIndex,
    String? selectedSize,
    bool? isWishlisted,
    int? remainingSeconds,
    bool? isFlashSaleActive,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      selectedVariantIndex: selectedVariantIndex ?? this.selectedVariantIndex,
      selectedSize: selectedSize ?? this.selectedSize,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isFlashSaleActive: isFlashSaleActive ?? this.isFlashSaleActive,
    );
  }

  @override
  List<Object?> get props => [
        product,
        selectedVariantIndex,
        selectedSize,
        isWishlisted,
        remainingSeconds,
        isFlashSaleActive,
      ];
}

class ProductDetailsError extends ProductDetailsState {
  final Failure failure;

  const ProductDetailsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
