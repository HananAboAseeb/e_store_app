import '../../domain/entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.validUntil,
    super.isExpiring,
    super.daysLeft,
    required super.iconType,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      validUntil: json['validUntil'] as String,
      isExpiring: json['isExpiring'] as bool? ?? false,
      daysLeft: json['daysLeft'] as int? ?? 0,
      iconType: json['iconType'] as String? ?? 'bag',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'validUntil': validUntil,
      'isExpiring': isExpiring,
      'daysLeft': daysLeft,
      'iconType': iconType,
    };
  }

  factory VoucherModel.fromEntity(VoucherEntity entity) {
    return VoucherModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      validUntil: entity.validUntil,
      isExpiring: entity.isExpiring,
      daysLeft: entity.daysLeft,
      iconType: entity.iconType,
    );
  }
}
