import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/announcement_entity.dart';
import '../../../domain/entities/profile_enums.dart';
import '../../../domain/usecases/get_announcement_usecase.dart';
import '../../../domain/usecases/get_recently_viewed_usecase.dart';
import '../../../domain/usecases/get_stories_usecase.dart';
import '../../../domain/usecases/get_user_profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final GetAnnouncementUseCase getAnnouncementUseCase;
  final GetRecentlyViewedUseCase getRecentlyViewedUseCase;
  final GetStoriesUseCase getStoriesUseCase;

  ProfileCubit({
    required this.getUserProfileUseCase,
    required this.getAnnouncementUseCase,
    required this.getRecentlyViewedUseCase,
    required this.getStoriesUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final userResult = await getUserProfileUseCase();
    final announcementResult = await getAnnouncementUseCase();
    final recentlyViewedResult = await getRecentlyViewedUseCase();
    final storiesResult = await getStoriesUseCase();

    userResult.fold(
      (failure) => emit(ProfileError(failure)),
      (user) {
        announcementResult.fold(
          (failure) => emit(ProfileError(failure)),
          (announcement) {
            recentlyViewedResult.fold(
              (failure) => emit(ProfileError(failure)),
              (recentlyViewed) {
                storiesResult.fold(
                  (failure) => emit(ProfileError(failure)),
                  (stories) {
                    emit(ProfileLoaded(
                      user: user,
                      announcement: announcement,
                      recentlyViewed: recentlyViewed,
                      stories: stories,
                    ));
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void cycleAnnouncementType() {
    if (state is ProfileLoaded) {
      final currentType = (state as ProfileLoaded).announcement.type;
      final nextType = switch (currentType) {
        ProfileAnnouncementType.regular => ProfileAnnouncementType.rewardEarned,
        ProfileAnnouncementType.rewardEarned =>
          ProfileAnnouncementType.voucherExpiring,
        ProfileAnnouncementType.voucherExpiring =>
          ProfileAnnouncementType.regular,
      };
      setAnnouncementType(nextType);
    }
  }

  void setAnnouncementType(ProfileAnnouncementType type) {
    if (state is ProfileLoaded) {
      final current = state as ProfileLoaded;
      final String title;
      const subtitle =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas hendrerit luctus libero ac vulputate.';
      const actionRoute = '/profile/rewards';

      switch (type) {
        case ProfileAnnouncementType.regular:
          title = 'Announcement';
          break;
        case ProfileAnnouncementType.rewardEarned:
          title = 'You just got a Reward';
          break;
        case ProfileAnnouncementType.voucherExpiring:
          title = 'Your Voucher will expire in 3 days';
          break;
      }

      final updatedAnnouncement = AnnouncementEntity(
        id: 'ann_${type.name}',
        title: title,
        subtitle: subtitle,
        type: type,
        actionRoute: actionRoute,
      );

      emit(current.copyWith(announcement: updatedAnnouncement));
    }
  }
}
