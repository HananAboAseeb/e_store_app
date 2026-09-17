import 'package:equatable/equatable.dart';

class RecommendationEntity extends Equatable {
  final String id;
  final String label;

  const RecommendationEntity({
    required this.id,
    required this.label,
  });

  @override
  List<Object?> get props => [id, label];
}
