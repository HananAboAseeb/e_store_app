import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/announcement_entity.dart';
import '../../../domain/entities/recently_viewed_item_entity.dart';
import '../../../domain/entities/story_entity.dart';
import '../../../domain/entities/user_profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileEntity user;
  final AnnouncementEntity announcement;
  final List<RecentlyViewedItemEntity> recentlyViewed;
  final List<StoryEntity> stories;

  const ProfileLoaded({
    required this.user,
    required this.announcement,
    required this.recentlyViewed,
    required this.stories,
  });

  ProfileLoaded copyWith({
    UserProfileEntity? user,
    AnnouncementEntity? announcement,
    List<RecentlyViewedItemEntity>? recentlyViewed,
    List<StoryEntity>? stories,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      announcement: announcement ?? this.announcement,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      stories: stories ?? this.stories,
    );
  }

  @override
  List<Object?> get props => [user, announcement, recentlyViewed, stories];
}

class ProfileError extends ProfileState {
  final Failure failure;

  const ProfileError(this.failure);

  @override
  List<Object?> get props => [failure];
}
