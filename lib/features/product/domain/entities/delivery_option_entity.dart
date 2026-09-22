import 'package:equatable/equatable.dart';

class DeliveryOptionEntity extends Equatable {
  final String id;
  final String name;
  final String estimatedDays;
  final double price;

  const DeliveryOptionEntity({
    required this.id,
    required this.name,
    required this.estimatedDays,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, estimatedDays, price];
}
