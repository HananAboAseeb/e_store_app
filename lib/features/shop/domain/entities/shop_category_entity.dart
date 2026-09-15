import 'package:equatable/equatable.dart';

class ShopCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String assetPath;
  final bool isSelected;

  const ShopCategoryEntity({
    required this.id,
    required this.name,
    required this.assetPath,
    this.isSelected = false,
  });

  ShopCategoryEntity copyWith({
    String? id,
    String? name,
    String? assetPath,
    bool? isSelected,
  }) {
    return ShopCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      assetPath: assetPath ?? this.assetPath,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, assetPath, isSelected];
}
