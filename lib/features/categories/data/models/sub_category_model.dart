import '../../domain/entities/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.id,
    required super.name,
    required super.parentGroupId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentGroupId: json['parentGroupId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentGroupId': parentGroupId,
    };
  }

  factory SubCategoryModel.fromEntity(SubCategoryEntity entity) {
    return SubCategoryModel(
      id: entity.id,
      name: entity.name,
      parentGroupId: entity.parentGroupId,
    );
  }
}
