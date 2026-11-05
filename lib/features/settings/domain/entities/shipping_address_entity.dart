import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String id;
  final String country;
  final String addressLine;
  final String city;
  final String postcode;
  final String phoneNumber;

  const ShippingAddressEntity({
    required this.id,
    required this.country,
    required this.addressLine,
    required this.city,
    required this.postcode,
    required this.phoneNumber,
  });

  ShippingAddressEntity copyWith({
    String? id,
    String? country,
    String? addressLine,
    String? city,
    String? postcode,
    String? phoneNumber,
  }) {
    return ShippingAddressEntity(
      id: id ?? this.id,
      country: country ?? this.country,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        country,
        addressLine,
        city,
        postcode,
        phoneNumber,
      ];
}
