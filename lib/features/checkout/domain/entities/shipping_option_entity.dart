import 'package:equatable/equatable.dart';

class ShippingOptionEntity extends Equatable {
  final String id;
  final String name;
  final String duration;
  final double price;
  final String estimatedDate;
  final bool isSelected;

  const ShippingOptionEntity({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.estimatedDate,
    this.isSelected = false,
  });

  ShippingOptionEntity copyWith({
    String? id,
    String? name,
    String? duration,
    double? price,
    String? estimatedDate,
    bool? isSelected,
  }) {
    return ShippingOptionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        price,
        estimatedDate,
        isSelected,
      ];
}
