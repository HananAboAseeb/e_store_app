import 'package:equatable/equatable.dart';

class VoucherEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double discountPercentage;
  final String validUntil;
  final String code;
  final String iconType;

  const VoucherEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.validUntil,
    required this.code,
    this.iconType = 'default',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        discountPercentage,
        validUntil,
        code,
        iconType,
      ];
}
