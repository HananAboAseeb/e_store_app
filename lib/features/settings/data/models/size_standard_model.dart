import '../../domain/entities/size_standard_entity.dart';

class SizeStandardModel extends SizeStandardEntity {
  const SizeStandardModel({
    required super.id,
    required super.label,
    super.isSelected = false,
  });

  factory SizeStandardModel.fromEntity(SizeStandardEntity entity) {
    return SizeStandardModel(
      id: entity.id,
      label: entity.label,
      isSelected: entity.isSelected,
    );
  }

  factory SizeStandardModel.fromJson(Map<String, dynamic> json) {
    return SizeStandardModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  @override
  SizeStandardModel copyWith({
    String? id,
    String? label,
    bool? isSelected,
  }) {
    return SizeStandardModel(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'isSelected': isSelected,
    };
  }
}
