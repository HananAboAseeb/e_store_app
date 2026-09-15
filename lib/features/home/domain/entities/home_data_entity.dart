import 'package:equatable/equatable.dart';

class HomeBannerEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final int discountPercentage;

  const HomeBannerEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.discountPercentage,
  });

  @override
  List<Object?> get props =>
      [id, title, subtitle, imageUrl, discountPercentage];
}

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final int itemCount;
  final List<String> previewImageUrls;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.previewImageUrls,
  });

  @override
  List<Object?> get props => [id, name, itemCount, previewImageUrls];
}

class HomeProductEntity extends Equatable {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final int? discountPercentage;
  final int? likeCount;
  final String? tag;
  final bool isFavorite;

  const HomeProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discountPercentage,
    this.likeCount,
    this.tag,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        imageUrl,
        discountPercentage,
        likeCount,
        tag,
        isFavorite,
      ];
}

class HomeDataEntity extends Equatable {
  final List<HomeBannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<HomeProductEntity> topProducts;
  final List<HomeProductEntity> newItems;
  final List<HomeProductEntity> flashSaleProducts;
  final List<HomeProductEntity> popularProducts;
  final List<HomeProductEntity> stuffForYouProducts;

  const HomeDataEntity({
    required this.banners,
    required this.categories,
    required this.topProducts,
    required this.newItems,
    required this.flashSaleProducts,
    required this.popularProducts,
    required this.stuffForYouProducts,
  });

  @override
  List<Object?> get props => [
        banners,
        categories,
        topProducts,
        newItems,
        flashSaleProducts,
        popularProducts,
        stuffForYouProducts,
      ];
}
