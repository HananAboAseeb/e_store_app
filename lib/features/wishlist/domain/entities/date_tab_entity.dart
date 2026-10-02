import 'package:equatable/equatable.dart';

class DateTabEntity extends Equatable {
  final String id;
  final String label;
  final DateTime? date;
  final bool isPreset;

  const DateTabEntity({
    required this.id,
    required this.label,
    this.date,
    this.isPreset = true,
  });

  DateTabEntity copyWith({
    String? id,
    String? label,
    DateTime? date,
    bool? isPreset,
  }) {
    return DateTabEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      date: date ?? this.date,
      isPreset: isPreset ?? this.isPreset,
    );
  }

  @override
  List<Object?> get props => [id, label, date, isPreset];
}
