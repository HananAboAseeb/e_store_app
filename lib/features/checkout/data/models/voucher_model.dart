import '../../domain/entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.id,
    required super.title,
    required super.description,
    required super.discountPercentage,
    required super.validUntil,
    required super.code,
    super.iconType,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      validUntil: json['validUntil'] as String? ?? '',
      code: json['code'] as String? ?? '',
      iconType: json['iconType'] as String? ?? 'default',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'discountPercentage': discountPercentage,
      'validUntil': validUntil,
      'code': code,
      'iconType': iconType,
    };
  }

  factory VoucherModel.fromEntity(VoucherEntity entity) {
    return VoucherModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      discountPercentage: entity.discountPercentage,
      validUntil: entity.validUntil,
      code: entity.code,
      iconType: entity.iconType,
    );
  }

  VoucherEntity toEntity() => this;
}
