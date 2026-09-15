import 'package:flutter/material.dart';

import '../../domain/entities/category_group_entity.dart';
import '../../domain/entities/gender_filter.dart';
import 'sub_category_model.dart';

class CategoryGroupModel extends CategoryGroupEntity {
  const CategoryGroupModel({
    required super.id,
    required super.name,
    required super.icon,
    super.gender,
    super.subCategories,
    super.isExpanded,
  });

  factory CategoryGroupModel.fromJson(Map<String, dynamic> json) {
    return CategoryGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: _getIconForId(json['id'] as String),
      gender: GenderFilter.values.firstWhere(
        (g) => g.name == json['gender'],
        orElse: () => GenderFilter.all,
      ),
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map(
                (e) => SubCategoryModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      isExpanded: json['isExpanded'] as bool? ?? false,
    );
  }

  static IconData _getIconForId(String id) {
    switch (id) {
      case 'clothing':
        return Icons.checkroom;
      case 'shoes':
        return Icons.directions_run_outlined;
      case 'bags':
        return Icons.shopping_bag_outlined;
      case 'accesories':
        return Icons.grid_view_rounded;
      default:
        return Icons.category_outlined;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
      'gender': gender.name,
      'subCategories': subCategories
          .map((e) => SubCategoryModel.fromEntity(e).toJson())
          .toList(),
      'isExpanded': isExpanded,
    };
  }

  factory CategoryGroupModel.fromEntity(CategoryGroupEntity entity) {
    return CategoryGroupModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      gender: entity.gender,
      subCategories: entity.subCategories,
      isExpanded: entity.isExpanded,
    );
  }
}
