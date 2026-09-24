import '../../domain/entities/shipping_option_entity.dart';

class ShippingOptionModel extends ShippingOptionEntity {
  const ShippingOptionModel({
    required super.id,
    required super.name,
    required super.duration,
    required super.price,
    required super.estimatedDate,
    super.isSelected,
  });

  factory ShippingOptionModel.fromJson(Map<String, dynamic> json) {
    return ShippingOptionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      estimatedDate: json['estimatedDate'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'price': price,
      'estimatedDate': estimatedDate,
      'isSelected': isSelected,
    };
  }

  factory ShippingOptionModel.fromEntity(ShippingOptionEntity entity) {
    return ShippingOptionModel(
      id: entity.id,
      name: entity.name,
      duration: entity.duration,
      price: entity.price,
      estimatedDate: entity.estimatedDate,
      isSelected: entity.isSelected,
    );
  }

  @override
  ShippingOptionModel copyWith({
    String? id,
    String? name,
    String? duration,
    double? price,
    String? estimatedDate,
    bool? isSelected,
  }) {
    return ShippingOptionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  ShippingOptionEntity toEntity() => this;
}
