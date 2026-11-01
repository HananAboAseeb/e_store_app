import '../../domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.creatorName,
    required super.imageUrl,
    super.isLive,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as String,
      creatorName: json['creatorName'] as String,
      imageUrl: json['imageUrl'] as String,
      isLive: json['isLive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorName': creatorName,
      'imageUrl': imageUrl,
      'isLive': isLive,
    };
  }

  factory StoryModel.fromEntity(StoryEntity entity) {
    return StoryModel(
      id: entity.id,
      creatorName: entity.creatorName,
      imageUrl: entity.imageUrl,
      isLive: entity.isLive,
    );
  }
}
