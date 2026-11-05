import '../../domain/entities/language_entity.dart';

class LanguageModel extends LanguageEntity {
  const LanguageModel({
    required super.id,
    required super.name,
    required super.nativeName,
    required super.localeCode,
    super.isSelected = false,
  });

  factory LanguageModel.fromEntity(LanguageEntity entity) {
    return LanguageModel(
      id: entity.id,
      name: entity.name,
      nativeName: entity.nativeName,
      localeCode: entity.localeCode,
      isSelected: entity.isSelected,
    );
  }

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nativeName: json['nativeName'] as String? ?? '',
      localeCode: json['localeCode'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  @override
  LanguageModel copyWith({
    String? id,
    String? name,
    String? nativeName,
    String? localeCode,
    bool? isSelected,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      localeCode: localeCode ?? this.localeCode,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nativeName': nativeName,
      'localeCode': localeCode,
      'isSelected': isSelected,
    };
  }
}
