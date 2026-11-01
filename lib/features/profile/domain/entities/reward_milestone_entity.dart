import 'package:equatable/equatable.dart';

class RewardMilestoneEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconType;
  final bool isEarned;

  const RewardMilestoneEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconType,
    this.isEarned = false,
  });

  @override
  List<Object?> get props => [id, title, description, iconType, isEarned];
}
