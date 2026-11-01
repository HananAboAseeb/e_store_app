import '../../domain/entities/reward_milestone_entity.dart';

class RewardMilestoneModel extends RewardMilestoneEntity {
  const RewardMilestoneModel({
    required super.id,
    required super.title,
    required super.description,
    required super.iconType,
    super.isEarned,
  });

  factory RewardMilestoneModel.fromJson(Map<String, dynamic> json) {
    return RewardMilestoneModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconType: json['iconType'] as String,
      isEarned: json['isEarned'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconType': iconType,
      'isEarned': isEarned,
    };
  }

  factory RewardMilestoneModel.fromEntity(RewardMilestoneEntity entity) {
    return RewardMilestoneModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      iconType: entity.iconType,
      isEarned: entity.isEarned,
    );
  }
}
