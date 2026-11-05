import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required super.id,
    required super.country,
    required super.addressLine,
    required super.city,
    required super.postcode,
    required super.phoneNumber,
  });

  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      id: entity.id,
      country: entity.country,
      addressLine: entity.addressLine,
      city: entity.city,
      postcode: entity.postcode,
      phoneNumber: entity.phoneNumber,
    );
  }

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id'] as String? ?? '',
      country: json['country'] as String? ?? '',
      addressLine: json['addressLine'] as String? ?? '',
      city: json['city'] as String? ?? '',
      postcode: json['postcode'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'addressLine': addressLine,
      'city': city,
      'postcode': postcode,
      'phoneNumber': phoneNumber,
    };
  }
}
