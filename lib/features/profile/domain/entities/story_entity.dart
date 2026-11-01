import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String id;
  final String creatorName;
  final String imageUrl;
  final bool isLive;

  const StoryEntity({
    required this.id,
    required this.creatorName,
    required this.imageUrl,
    this.isLive = false,
  });

  @override
  List<Object?> get props => [id, creatorName, imageUrl, isLive];
}
