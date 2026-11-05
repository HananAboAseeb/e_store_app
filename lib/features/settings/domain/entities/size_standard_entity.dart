import 'package:equatable/equatable.dart';

class SizeStandardEntity extends Equatable {
  final String id;
  final String label; // "US", "EU", "UK"
  final bool isSelected;

  const SizeStandardEntity({
    required this.id,
    required this.label,
    this.isSelected = false,
  });

  SizeStandardEntity copyWith({
    String? id,
    String? label,
    bool? isSelected,
  }) {
    return SizeStandardEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, label, isSelected];
}
