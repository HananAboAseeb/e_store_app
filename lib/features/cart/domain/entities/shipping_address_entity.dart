import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String id;
  final String country;
  final String city;
  final String state;
  final String street;
  final String zipCode;

  const ShippingAddressEntity({
    required this.id,
    required this.country,
    required this.city,
    required this.state,
    required this.street,
    required this.zipCode,
  });

  String get formattedAddress =>
      '$country, $city, $state / $street, $city, $state $zipCode';

  ShippingAddressEntity copyWith({
    String? id,
    String? country,
    String? city,
    String? state,
    String? street,
    String? zipCode,
  }) {
    return ShippingAddressEntity(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        country,
        city,
        state,
        street,
        zipCode,
      ];
}
