import '../../domain/entities/category_spending_entity.dart';

class CategorySpendingModel extends CategorySpendingEntity {
  const CategorySpendingModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.colorTokenKey,
  });

  factory CategorySpendingModel.fromJson(Map<String, dynamic> json) {
    return CategorySpendingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      colorTokenKey: json['colorTokenKey'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'colorTokenKey': colorTokenKey,
    };
  }

  factory CategorySpendingModel.fromEntity(CategorySpendingEntity entity) {
    return CategorySpendingModel(
      id: entity.id,
      name: entity.name,
      amount: entity.amount,
      colorTokenKey: entity.colorTokenKey,
    );
  }
}
