import '../../domain/entities/rating_breakdown_entity.dart';

class RatingBreakdownModel extends RatingBreakdownEntity {
  const RatingBreakdownModel({
    required super.stars,
    required super.percentage,
  });

  factory RatingBreakdownModel.fromJson(Map<String, dynamic> json) {
    return RatingBreakdownModel(
      stars: json['stars'] as int? ?? 5,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stars': stars,
      'percentage': percentage,
    };
  }

  factory RatingBreakdownModel.fromEntity(RatingBreakdownEntity entity) {
    return RatingBreakdownModel(
      stars: entity.stars,
      percentage: entity.percentage,
    );
  }
}
