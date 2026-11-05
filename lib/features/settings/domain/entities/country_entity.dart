import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String code;
  final bool isSelected;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.code,
    this.isSelected = false,
  });

  CountryEntity copyWith({
    String? id,
    String? name,
    String? code,
    bool? isSelected,
  }) {
    return CountryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, code, isSelected];
}
