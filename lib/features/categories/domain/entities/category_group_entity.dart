import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'gender_filter.dart';
import 'sub_category_entity.dart';

class CategoryGroupEntity extends Equatable {
  final String id;
  final String name;
  final IconData icon;
  final GenderFilter gender;
  final List<SubCategoryEntity> subCategories;
  final bool isExpanded;

  const CategoryGroupEntity({
    required this.id,
    required this.name,
    required this.icon,
    this.gender = GenderFilter.all,
    this.subCategories = const [],
    this.isExpanded = false,
  });

  CategoryGroupEntity copyWith({
    String? id,
    String? name,
    IconData? icon,
    GenderFilter? gender,
    List<SubCategoryEntity>? subCategories,
    bool? isExpanded,
  }) {
    return CategoryGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      gender: gender ?? this.gender,
      subCategories: subCategories ?? this.subCategories,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, icon, gender, subCategories, isExpanded];
}
