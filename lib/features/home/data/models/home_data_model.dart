import '../../domain/entities/home_data_entity.dart';

class HomeBannerModel extends HomeBannerEntity {
  const HomeBannerModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.discountPercentage,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      discountPercentage: (json['discountPercentage'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'discountPercentage': discountPercentage,
    };
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.itemCount,
    required super.previewImageUrls,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      itemCount: (json['itemCount'] as num).toInt(),
      previewImageUrls: List<String>.from(json['previewImageUrls'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'itemCount': itemCount,
      'previewImageUrls': previewImageUrls,
    };
  }
}

class HomeProductModel extends HomeProductEntity {
  const HomeProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.imageUrl,
    super.discountPercentage,
    super.likeCount,
    super.tag,
    super.isFavorite = false,
  });

  factory HomeProductModel.fromJson(Map<String, dynamic> json) {
    return HomeProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toInt()
          : null,
      likeCount:
          json['likeCount'] != null ? (json['likeCount'] as num).toInt() : null,
      tag: json['tag'] as String?,
      isFavorite: (json['isFavorite'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'discountPercentage': discountPercentage,
      'likeCount': likeCount,
      'tag': tag,
      'isFavorite': isFavorite,
    };
  }
}

class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required List<HomeBannerModel> super.banners,
    required List<CategoryModel> super.categories,
    required List<HomeProductModel> super.topProducts,
    required List<HomeProductModel> super.newItems,
    required List<HomeProductModel> super.flashSaleProducts,
    required List<HomeProductModel> super.popularProducts,
    required List<HomeProductModel> super.stuffForYouProducts,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      banners: (json['banners'] as List)
          .map((e) => HomeBannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topProducts: (json['topProducts'] as List)
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newItems: (json['newItems'] as List)
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      flashSaleProducts: (json['flashSaleProducts'] as List)
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularProducts: (json['popularProducts'] as List)
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stuffForYouProducts: (json['stuffForYouProducts'] as List)
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
