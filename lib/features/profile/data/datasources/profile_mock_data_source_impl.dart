import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/profile_enums.dart';
import '../models/activity_summary_model.dart';
import '../models/announcement_model.dart';
import '../models/category_spending_model.dart';
import '../models/order_stats_model.dart';
import '../models/recently_viewed_item_model.dart';
import '../models/reward_milestone_model.dart';
import '../models/story_model.dart';
import '../models/user_profile_model.dart';
import '../models/voucher_model.dart';
import 'profile_mock_data_source.dart';

class ProfileMockDataSourceImpl implements ProfileMockDataSource {
  // Allow toggling active announcement type for demonstration & testing
  ProfileAnnouncementType currentAnnouncementType =
      ProfileAnnouncementType.regular;

  @override
  Future<UserProfileModel> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const UserProfileModel(
      id: 'user_romina',
      name: 'Romina',
      greeting: 'Hello, Romina!',
      avatarUrl: 'assets/images/profile_picture.png',
    );
  }

  @override
  Future<AnnouncementModel> getAnnouncement() async {
    await Future.delayed(const Duration(milliseconds: 200));
    switch (currentAnnouncementType) {
      case ProfileAnnouncementType.regular:
        return const AnnouncementModel(
          id: 'ann_regular',
          title: 'Announcement',
          subtitle:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas hendrerit luctus libero ac vulputate.',
          type: ProfileAnnouncementType.regular,
          actionRoute: null,
        );
      case ProfileAnnouncementType.rewardEarned:
        return const AnnouncementModel(
          id: 'ann_reward',
          title: 'You just got a Reward',
          subtitle:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas hendrerit luctus libero ac vulputate.',
          type: ProfileAnnouncementType.rewardEarned,
          actionRoute: '/profile/rewards',
        );
      case ProfileAnnouncementType.voucherExpiring:
        return const AnnouncementModel(
          id: 'ann_voucher_expiring',
          title: 'Your Voucher will expire in 3 days',
          subtitle:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas hendrerit luctus libero ac vulputate.',
          type: ProfileAnnouncementType.voucherExpiring,
          actionRoute: '/profile/rewards',
        );
    }
  }

  @override
  Future<List<RecentlyViewedItemModel>> getRecentlyViewed() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      RecentlyViewedItemModel(
        id: 'rv_1',
        viewedAt: DateTime.now().subtract(const Duration(hours: 1)),
        product: ShopProductModel(
          id: 'prod_1',
          title: 'Black Wide Pants',
          imageUrl: 'assets/images/prod_20_1.png',
          price: 49.00,
          category: 'Clothing',
          subCategory: 'Pants',
          createdAt: DateTime(2026, 4, 1),
        ),
      ),
      RecentlyViewedItemModel(
        id: 'rv_2',
        viewedAt: DateTime.now().subtract(const Duration(hours: 3)),
        product: ShopProductModel(
          id: 'prod_2',
          title: 'Sky Blue Two-Piece Set',
          imageUrl: 'assets/images/prod_20_2.png',
          price: 75.00,
          category: 'Clothing',
          subCategory: 'Sets',
          createdAt: DateTime(2026, 4, 2),
        ),
      ),
      RecentlyViewedItemModel(
        id: 'rv_3',
        viewedAt: DateTime.now().subtract(const Duration(hours: 6)),
        product: ShopProductModel(
          id: 'prod_3',
          title: 'Formal Black Shirt',
          imageUrl: 'assets/images/prod_20_3.png',
          price: 59.00,
          category: 'Clothing',
          subCategory: 'Shirts',
          createdAt: DateTime(2026, 4, 3),
        ),
      ),
      RecentlyViewedItemModel(
        id: 'rv_4',
        viewedAt: DateTime.now().subtract(const Duration(days: 1)),
        product: ShopProductModel(
          id: 'prod_4',
          title: 'Brown Sport Lounge Set',
          imageUrl: 'assets/images/prod_20_4.png',
          price: 62.00,
          category: 'Clothing',
          subCategory: 'Sets',
          createdAt: DateTime(2026, 4, 4),
        ),
      ),
      RecentlyViewedItemModel(
        id: 'rv_5',
        viewedAt: DateTime.now().subtract(const Duration(days: 2)),
        product: ShopProductModel(
          id: 'prod_5',
          title: 'Casual Black Blouse',
          imageUrl: 'assets/images/prod_20_5.png',
          price: 39.00,
          category: 'Clothing',
          subCategory: 'Blouse',
          createdAt: DateTime(2026, 4, 5),
        ),
      ),
    ];
  }

  @override
  Future<List<StoryModel>> getStories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      StoryModel(
        id: 'story_1',
        creatorName: 'Alex',
        imageUrl: 'assets/images/girl_image.png',
        isLive: true,
      ),
      StoryModel(
        id: 'story_2',
        creatorName: 'Marcus',
        imageUrl: 'assets/images/profile_picture.png',
        isLive: false,
      ),
      StoryModel(
        id: 'story_3',
        creatorName: 'Lucas',
        imageUrl: 'assets/images/history_product.png',
        isLive: false,
      ),
      StoryModel(
        id: 'story_4',
        creatorName: 'Daniel',
        imageUrl: 'assets/images/image1.png',
        isLive: false,
      ),
    ];
  }

  @override
  Future<ActivitySummaryModel> getActivitySummary(String month) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return const ActivitySummaryModel(
      month: 'April',
      year: 2026,
      totalAmount: 365.00,
      categories: [
        CategorySpendingModel(
          id: 'cat_clothing',
          name: 'Clothing',
          amount: 183.00,
          colorTokenKey: 'chartBlue',
        ),
        CategorySpendingModel(
          id: 'cat_lingerie',
          name: 'Lingerie',
          amount: 92.00,
          colorTokenKey: 'chartGreen',
        ),
        CategorySpendingModel(
          id: 'cat_shoes',
          name: 'Shoes',
          amount: 47.00,
          colorTokenKey: 'chartOrange',
        ),
        CategorySpendingModel(
          id: 'cat_bags',
          name: 'Bags',
          amount: 43.00,
          colorTokenKey: 'chartRed',
        ),
      ],
      orderStats: OrderStatsModel(
        orderedCount: 12,
        receivedCount: 7,
        toReceiveCount: 5,
      ),
    );
  }

  @override
  Future<List<VoucherModel>> getVouchers() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      VoucherModel(
        id: 'voucher_care',
        title: 'From Customer Care',
        subtitle: '15% off your next purchase',
        validUntil: '5.16.20',
        isExpiring: true,
        daysLeft: 3,
        iconType: 'badge',
      ),
      VoucherModel(
        id: 'voucher_first',
        title: 'First Purchase',
        subtitle: '5% off for your next order',
        validUntil: '6.20.20',
        isExpiring: false,
        daysLeft: 0,
        iconType: 'bag',
      ),
      VoucherModel(
        id: 'voucher_loyal',
        title: 'Loyal Customer',
        subtitle: '10% off for your next order',
        validUntil: '6.20.20',
        isExpiring: false,
        daysLeft: 0,
        iconType: 'heart',
      ),
    ];
  }

  @override
  Future<List<RewardMilestoneModel>> getRewards() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      RewardMilestoneModel(
        id: 'rew_first',
        title: 'First Purchase',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'bag',
        isEarned: true,
      ),
      RewardMilestoneModel(
        id: 'rew_loyal',
        title: 'Loyal Customer',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'heart',
        isEarned: true,
      ),
      RewardMilestoneModel(
        id: 'rew_review',
        title: 'Review Maker',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'star',
        isEarned: false,
      ),
      RewardMilestoneModel(
        id: 'rew_soul',
        title: 'Big Soul',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'cloud',
        isEarned: false,
      ),
      RewardMilestoneModel(
        id: 'rew_expert',
        title: 'Cloth Expert',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'shirt',
        isEarned: false,
      ),
      RewardMilestoneModel(
        id: 'rew_10plus',
        title: '10+ Orders',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore',
        iconType: 'smile',
        isEarned: false,
      ),
    ];
  }
}
