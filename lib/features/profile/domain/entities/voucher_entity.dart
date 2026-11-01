import 'package:equatable/equatable.dart';

class VoucherEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String validUntil;
  final bool isExpiring;
  final int daysLeft;
  final String iconType;

  const VoucherEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.validUntil,
    this.isExpiring = false,
    this.daysLeft = 0,
    required this.iconType,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        validUntil,
        isExpiring,
        daysLeft,
        iconType,
      ];
}
