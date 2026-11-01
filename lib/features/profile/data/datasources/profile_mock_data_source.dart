import '../models/activity_summary_model.dart';
import '../models/announcement_model.dart';
import '../models/recently_viewed_item_model.dart';
import '../models/reward_milestone_model.dart';
import '../models/story_model.dart';
import '../models/user_profile_model.dart';
import '../models/voucher_model.dart';

abstract class ProfileMockDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<AnnouncementModel> getAnnouncement();
  Future<List<RecentlyViewedItemModel>> getRecentlyViewed();
  Future<List<StoryModel>> getStories();
  Future<ActivitySummaryModel> getActivitySummary(String month);
  Future<List<VoucherModel>> getVouchers();
  Future<List<RewardMilestoneModel>> getRewards();
}
