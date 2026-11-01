import 'package:equatable/equatable.dart';
import 'profile_enums.dart';

class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final ProfileAnnouncementType type;
  final String? actionRoute;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    this.actionRoute,
  });

  @override
  List<Object?> get props => [id, title, subtitle, type, actionRoute];
}
