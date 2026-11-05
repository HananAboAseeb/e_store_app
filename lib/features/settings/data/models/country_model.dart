import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
    required super.code,
    super.isSelected = false,
  });

  factory CountryModel.fromEntity(CountryEntity entity) {
    return CountryModel(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      isSelected: entity.isSelected,
    );
  }

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  @override
  CountryModel copyWith({
    String? id,
    String? name,
    String? code,
    bool? isSelected,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isSelected': isSelected,
    };
  }
}
