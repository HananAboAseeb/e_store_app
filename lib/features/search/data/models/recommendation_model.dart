import '../../domain/entities/recommendation_entity.dart';

class RecommendationModel extends RecommendationEntity {
  const RecommendationModel({
    required super.id,
    required super.label,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      id: json['id'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory RecommendationModel.fromEntity(RecommendationEntity entity) {
    return RecommendationModel(
      id: entity.id,
      label: entity.label,
    );
  }
}
