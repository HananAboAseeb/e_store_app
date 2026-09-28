import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/category_group_entity.dart';
import '../../domain/entities/gender_filter.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryGroupEntity> groups;
  final GenderFilter activeGender;
  final String? expandedGroupId;

  const CategoriesLoaded({
    required this.groups,
    this.activeGender = GenderFilter.all,
    this.expandedGroupId = 'clothing',
  });

  CategoriesLoaded copyWith({
    List<CategoryGroupEntity>? groups,
    GenderFilter? activeGender,
    String? expandedGroupId,
    bool clearExpandedGroupId = false,
  }) {
    return CategoriesLoaded(
      groups: groups ?? this.groups,
      activeGender: activeGender ?? this.activeGender,
      expandedGroupId: clearExpandedGroupId
          ? null
          : (expandedGroupId ?? this.expandedGroupId),
    );
  }

  @override
  List<Object?> get props => [groups, activeGender, expandedGroupId];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ── Just For You States (Screen 43 Enhancement) ───────────────────────

class JustForYouLoading extends CategoriesState {
  const JustForYouLoading();
}

class JustForYouLoaded extends CategoriesState {
  final List<ShopProductEntity> products;

  const JustForYouLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class JustForYouError extends CategoriesState {
  final String message;

  const JustForYouError({required this.message});

  @override
  List<Object?> get props => [message];
}
