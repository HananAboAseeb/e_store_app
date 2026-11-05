import 'package:equatable/equatable.dart';

class LanguageEntity extends Equatable {
  final String id;
  final String name;
  final String nativeName;
  final String localeCode;
  final bool isSelected;

  const LanguageEntity({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.localeCode,
    this.isSelected = false,
  });

  LanguageEntity copyWith({
    String? id,
    String? name,
    String? nativeName,
    String? localeCode,
    bool? isSelected,
  }) {
    return LanguageEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      localeCode: localeCode ?? this.localeCode,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, nativeName, localeCode, isSelected];
}
