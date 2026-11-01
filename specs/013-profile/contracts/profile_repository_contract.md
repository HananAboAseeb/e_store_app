# Contract: Profile Repository

**Feature**: `013-profile`  
**Date**: 2026-11-01  
**Layer**: Domain Repository Interface  

---

## Contract Definition

```dart
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
  Future<Either<Failure, ActivitySummaryEntity>> getActivitySummary(String month);

  /// Fetches available reward vouchers, including expiring statuses (Screens 82, 83)
  Future<Either<Failure, List<VoucherEntity>>> getVouchers();

  /// Fetches gamified achievement milestones and earned progress (Screen 84)
  Future<Either<Failure, List<RewardMilestoneEntity>>> getRewards();
}
```

---

## Use Cases (Domain Layer)

Each Use Case takes repository dependencies via constructor and exposes a `call()` method returning `Either<Failure, T>`:

1. **`GetUserProfileUseCase`**: Invokes `repository.getUserProfile()`
2. **`GetAnnouncementUseCase`**: Invokes `repository.getAnnouncement()`
3. **`GetRecentlyViewedUseCase`**: Invokes `repository.getRecentlyViewed()`
4. **`GetStoriesUseCase`**: Invokes `repository.getStories()`
5. **`GetActivitySummaryUseCase`**: Invokes `repository.getActivitySummary(month)`
6. **`GetVouchersUseCase`**: Invokes `repository.getVouchers()`
7. **`GetRewardsUseCase`**: Invokes `repository.getRewards()`

---

## Cubit State Contracts (Presentation Layer)

### 1. `ProfileCubit` (Screens 62, 81, 85)
- **`loadProfile()`**: Fetches user profile, announcement, recently viewed products, and stories.
- **`setAnnouncementType(ProfileAnnouncementType type)`**: Test/preview method to switch between Screens 62, 81, and 85 dynamically.
- **States**:
  - `ProfileInitial`
  - `ProfileLoading`
  - `ProfileLoaded`:
    - `user: UserProfileEntity`
    - `announcement: AnnouncementEntity`
    - `recentlyViewed: List<RecentlyViewedItemEntity>`
    - `stories: List<StoryEntity>`
  - `ProfileError`: `failure: Failure`

### 2. `MyActivityCubit` (Screen 64)
- **`loadActivity({String month = 'April'})`**: Loads monthly spending breakdown, donut arcs, and order statistics.
- **`changeMonth(int offset)`**: Navigates between months and updates data.
- **States**:
  - `MyActivityInitial`
  - `MyActivityLoading`
  - `MyActivityLoaded`:
    - `summary: ActivitySummaryEntity`
  - `MyActivityError`: `failure: Failure`

### 3. `RewardsCubit` (Screens 82, 83, 84)
- **`loadRewards()`**: Loads both active vouchers and progress milestones.
- **`switchTab(RewardsTab tab)`**: Changes between `activeRewards` and `progress`.
- **States**:
  - `RewardsInitial`
  - `RewardsLoading`
  - `RewardsLoaded`:
    - `activeTab: RewardsTab`
    - `vouchers: List<VoucherEntity>`
    - `rewards: List<RewardMilestoneEntity>`
    - `hasExpiringVoucher: bool`
  - `RewardsError`: `failure: Failure`

