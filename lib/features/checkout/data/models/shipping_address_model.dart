import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required super.id,
    required super.country,
    required super.city,
    required super.street,
    required super.zipCode,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id'] as String? ?? '',
      country: json['country'] as String? ?? '',
      city: json['city'] as String? ?? '',
      street: json['street'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'street': street,
      'zipCode': zipCode,
    };
  }

  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      id: entity.id,
      country: entity.country,
      city: entity.city,
      street: entity.street,
      zipCode: entity.zipCode,
    );
  }

  ShippingAddressEntity toEntity() => this;
}
