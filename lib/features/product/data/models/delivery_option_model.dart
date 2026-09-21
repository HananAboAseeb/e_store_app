import '../../domain/entities/delivery_option_entity.dart';

class DeliveryOptionModel extends DeliveryOptionEntity {
  const DeliveryOptionModel({
    required super.id,
    required super.name,
    required super.estimatedDays,
    required super.price,
  });

  factory DeliveryOptionModel.fromJson(Map<String, dynamic> json) {
    return DeliveryOptionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      estimatedDays: json['estimatedDays'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'estimatedDays': estimatedDays,
      'price': price,
    };
  }

  factory DeliveryOptionModel.fromEntity(DeliveryOptionEntity entity) {
    return DeliveryOptionModel(
      id: entity.id,
      name: entity.name,
      estimatedDays: entity.estimatedDays,
      price: entity.price,
    );
  }
}
