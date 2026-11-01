import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/activity_summary_entity.dart';
import '../entities/announcement_entity.dart';
import '../entities/recently_viewed_item_entity.dart';
import '../entities/reward_milestone_entity.dart';
import '../entities/story_entity.dart';
import '../entities/user_profile_entity.dart';
import '../entities/voucher_entity.dart';

abstract class ProfileRepository {
  /// Fetches authenticated user profile details (avatar, greeting, name)
  Future<Either<Failure, UserProfileEntity>> getUserProfile();

  /// Fetches active announcement for the Profile Home screen (Screens 62, 81, 85)
  Future<Either<Failure, AnnouncementEntity>> getAnnouncement();

  /// Fetches recently viewed items for Profile Home
  Future<Either<Failure, List<RecentlyViewedItemEntity>>> getRecentlyViewed();

  /// Fetches creator stories for Profile Home
  Future<Either<Failure, List<StoryEntity>>> getStories();

  /// Fetches monthly spending breakdown, category expenditures, and order statistics (Screen 64)
  Future<Either<Failure, ActivitySummaryEntity>> getActivitySummary(
      String month);

  /// Fetches available reward vouchers, including expiring statuses (Screens 82, 83)
  Future<Either<Failure, List<VoucherEntity>>> getVouchers();

  /// Fetches gamified achievement milestones and earned progress (Screen 84)
  Future<Either<Failure, List<RewardMilestoneEntity>>> getRewards();
}
