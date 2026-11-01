import '../../domain/entities/announcement_entity.dart';
import '../../domain/entities/profile_enums.dart';

class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.type,
    super.actionRoute,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      type: ProfileAnnouncementType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ProfileAnnouncementType.regular,
      ),
      actionRoute: json['actionRoute'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type.name,
      'actionRoute': actionRoute,
    };
  }

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      type: entity.type,
      actionRoute: entity.actionRoute,
    );
  }
}
