import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/activity_summary_entity.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';
import '../../domain/entities/reward_milestone_entity.dart';
import '../../domain/entities/story_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/voucher_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_mock_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileMockDataSource mockDataSource;

  ProfileRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    return await safeCall(() => mockDataSource.getUserProfile());
  }

  @override
  Future<Either<Failure, AnnouncementEntity>> getAnnouncement() async {
    return await safeCall(() => mockDataSource.getAnnouncement());
  }

  @override
  Future<Either<Failure, List<RecentlyViewedItemEntity>>>
      getRecentlyViewed() async {
    return await safeCall(() => mockDataSource.getRecentlyViewed());
  }

  @override
  Future<Either<Failure, List<StoryEntity>>> getStories() async {
    return await safeCall(() => mockDataSource.getStories());
  }

  @override
  Future<Either<Failure, ActivitySummaryEntity>> getActivitySummary(
      String month) async {
    return await safeCall(() => mockDataSource.getActivitySummary(month));
  }

  @override
  Future<Either<Failure, List<VoucherEntity>>> getVouchers() async {
    return await safeCall(() => mockDataSource.getVouchers());
  }

  @override
  Future<Either<Failure, List<RewardMilestoneEntity>>> getRewards() async {
    return await safeCall(() => mockDataSource.getRewards());
  }
}
