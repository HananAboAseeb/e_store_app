import '../../domain/entities/specification_entity.dart';

class SpecificationModel extends SpecificationEntity {
  const SpecificationModel({
    required super.label,
    required super.values,
  });

  factory SpecificationModel.fromJson(Map<String, dynamic> json) {
    return SpecificationModel(
      label: json['label'] as String? ?? '',
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'values': values,
    };
  }

  factory SpecificationModel.fromEntity(SpecificationEntity entity) {
    return SpecificationModel(
      label: entity.label,
      values: entity.values,
    );
  }
}
