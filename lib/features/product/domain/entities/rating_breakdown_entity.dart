import 'package:equatable/equatable.dart';

class RatingBreakdownEntity extends Equatable {
  final int stars;
  final double percentage;

  const RatingBreakdownEntity({
    required this.stars,
    required this.percentage,
  });

  @override
  List<Object?> get props => [stars, percentage];
}
