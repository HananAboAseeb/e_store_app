import 'package:flutter/material.dart';

import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/gender_filter.dart';
import '../models/category_group_model.dart';
import '../models/sub_category_model.dart';
import 'categories_mock_datasource.dart';

class CategoriesMockDataSourceImpl implements CategoriesMockDataSource {
  // ── All category groups ──────────────────────────────────────────────
  static final List<CategoryGroupModel> _allGroups = [
    CategoryGroupModel(
      id: 'clothing',
      name: 'Clothing',
      icon: Icons.checkroom,
      gender: GenderFilter.all,
      subCategories: const [
        SubCategoryModel(
          id: 'dresses',
          name: 'Dresses',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'pants',
          name: 'Pants',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'skirts',
          name: 'Skirts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'shorts',
          name: 'Shorts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'jackets',
          name: 'Jackets',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'hoodies',
          name: 'Hoodies',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'shirts',
          name: 'Shirts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'polo',
          name: 'Polo',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 't_shirts',
          name: 'T-Shirts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'tunics',
          name: 'Tunics',
          parentGroupId: 'clothing',
        ),
      ],
    ),
    const CategoryGroupModel(
      id: 'shoes',
      name: 'Shoes',
      icon: Icons.directions_run_outlined,
      gender: GenderFilter.all,
    ),
    const CategoryGroupModel(
      id: 'bags',
      name: 'Bags',
      icon: Icons.shopping_bag_outlined,
      gender: GenderFilter.all,
    ),
    const CategoryGroupModel(
      id: 'accesories',
      name: 'Accesories',
      icon: Icons.grid_view_rounded,
      gender: GenderFilter.all,
    ),
  ];

  // ── Female-only groups ───────────────────────────────────────────────
  static final List<CategoryGroupModel> _femaleGroups = [
    CategoryGroupModel(
      id: 'clothing',
      name: 'Clothing',
      icon: Icons.checkroom,
      gender: GenderFilter.female,
      subCategories: const [
        SubCategoryModel(
          id: 'dresses',
          name: 'Dresses',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'skirts',
          name: 'Skirts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'tunics',
          name: 'Tunics',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'jackets',
          name: 'Jackets',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'hoodies',
          name: 'Hoodies',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'shirts',
          name: 'Shirts',
          parentGroupId: 'clothing',
        ),
      ],
    ),
    const CategoryGroupModel(
      id: 'shoes',
      name: 'Shoes',
      icon: Icons.directions_run_outlined,
      gender: GenderFilter.female,
    ),
    const CategoryGroupModel(
      id: 'bags',
      name: 'Bags',
      icon: Icons.shopping_bag_outlined,
      gender: GenderFilter.female,
    ),
    const CategoryGroupModel(
      id: 'accesories',
      name: 'Accesories',
      icon: Icons.grid_view_rounded,
      gender: GenderFilter.female,
    ),
  ];

  // ── Male-only groups ─────────────────────────────────────────────────
  static final List<CategoryGroupModel> _maleGroups = [
    CategoryGroupModel(
      id: 'clothing',
      name: 'Clothing',
      icon: Icons.checkroom,
      gender: GenderFilter.male,
      subCategories: const [
        SubCategoryModel(
          id: 'pants',
          name: 'Pants',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'shorts',
          name: 'Shorts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'jackets',
          name: 'Jackets',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'hoodies',
          name: 'Hoodies',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'shirts',
          name: 'Shirts',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 'polo',
          name: 'Polo',
          parentGroupId: 'clothing',
        ),
        SubCategoryModel(
          id: 't_shirts',
          name: 'T-Shirts',
          parentGroupId: 'clothing',
        ),
      ],
    ),
    const CategoryGroupModel(
      id: 'shoes',
      name: 'Shoes',
      icon: Icons.directions_run_outlined,
      gender: GenderFilter.male,
    ),
    const CategoryGroupModel(
      id: 'accesories',
      name: 'Accesories',
      icon: Icons.grid_view_rounded,
      gender: GenderFilter.male,
    ),
  ];

  @override
  Future<List<CategoryGroupModel>> getCategories({
    GenderFilter gender = GenderFilter.all,
  }) async {
    // Simulate network latency
    await Future<void>.delayed(const Duration(milliseconds: 300));

    switch (gender) {
      case GenderFilter.all:
        return _allGroups;
      case GenderFilter.female:
        return _femaleGroups;
      case GenderFilter.male:
        return _maleGroups;
    }
  }

  // ── Just for you mock products ───────────────────────────────────────
  static final List<ShopProductModel> _justForYouProducts = [
    ShopProductModel(
      id: 'jfy-1',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/cat_cloth_1.png',
      price: 17.0,
      category: 'Clothing',
      subCategory: 'Shirts',
      createdAt: DateTime(2026, 1, 1),
    ),
    ShopProductModel(
      id: 'jfy-2',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/cat_cloth_2.png',
      price: 17.0,
      category: 'Clothing',
      subCategory: 'T-Shirts',
      createdAt: DateTime(2026, 1, 2),
    ),
    ShopProductModel(
      id: 'jfy-3',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_1.png',
      price: 17.0,
      originalPrice: 24.0,
      isDiscounted: true,
      category: 'Clothing',
      subCategory: 'Tunics',
      createdAt: DateTime(2026, 1, 3),
    ),
    ShopProductModel(
      id: 'jfy-4',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_2.png',
      price: 17.0,
      category: 'Clothing',
      subCategory: 'Shirts',
      createdAt: DateTime(2026, 1, 4),
    ),
    ShopProductModel(
      id: 'jfy-5',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/prod_20_3.png',
      price: 17.0,
      category: 'Accesories',
      subCategory: 'Caps',
      createdAt: DateTime(2026, 1, 5),
    ),
    ShopProductModel(
      id: 'jfy-6',
      title: 'Lorem ipsum dolor sit amet consectetur',
      imageUrl: 'assets/images/cat_hoodie_1.png',
      price: 17.0,
      originalPrice: 28.0,
      isDiscounted: true,
      category: 'Clothing',
      subCategory: 'Hoodies',
      createdAt: DateTime(2026, 1, 6),
    ),
  ];

  @override
  Future<List<ShopProductModel>> getJustForYouProducts() async {
    // Simulate network latency
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _justForYouProducts;
  }
}
