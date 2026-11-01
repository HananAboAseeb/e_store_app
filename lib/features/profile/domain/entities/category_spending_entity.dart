import 'package:equatable/equatable.dart';

class CategorySpendingEntity extends Equatable {
  final String id;
  final String name;
  final double amount;
  final String colorTokenKey;

  const CategorySpendingEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.colorTokenKey,
  });

  @override
  List<Object?> get props => [id, name, amount, colorTokenKey];
}
