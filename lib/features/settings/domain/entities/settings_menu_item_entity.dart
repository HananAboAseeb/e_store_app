import 'package:equatable/equatable.dart';

enum SettingsSection { personal, shop, account }

class SettingsMenuItemEntity extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final SettingsSection section;
  final String routePath;

  const SettingsMenuItemEntity({
    required this.id,
    required this.title,
    this.subtitle,
    required this.section,
    required this.routePath,
  });

  @override
  List<Object?> get props => [id, title, subtitle, section, routePath];
}
