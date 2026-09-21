import 'package:equatable/equatable.dart';

class SpecificationEntity extends Equatable {
  final String label;
  final List<String> values;

  const SpecificationEntity({
    required this.label,
    required this.values,
  });

  @override
  List<Object?> get props => [label, values];
}
