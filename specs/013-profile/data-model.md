# Data Model: User Profile, Activity Dashboard & Rewards Center

**Feature**: `013-profile`  
**Date**: 2026-11-01  
**Status**: Completed  

---

## Domain Entities

### 1. `UserProfileEntity`
Represents the authenticated shopper profile information.
- **`id`**: `String` — Unique identifier for the user.
- **`name`**: `String` — Full display name (e.g., `"Romina"`).
- **`greeting`**: `String` — Personalized greeting title (e.g., `"Hello, Romina!"`).
- **`avatarUrl`**: `String` — Asset path or URL to user avatar (e.g., `'assets/images/profile_picture.png'`).

---

### 2. `AnnouncementEntity`
Represents the contextual banner displayed on Profile Home (Screens 62, 81, 85).
- **`id`**: `String` — Unique identifier.
- **`title`**: `String` — Headline text (`"Announcement"` / `"You just got a Reward"` / `"Your Voucher will expire in 3 days"`).
- **`subtitle`**: `String` — Descriptive copy text (`"Lorem ipsum dolor sit amet, consectetur adipiscing elit..."`).
- **`type`**: `ProfileAnnouncementType` (`regular`, `rewardEarned`, `voucherExpiring`) — Drives visual styling, badge icons, and backgrounds.
- **`actionRoute`**: `String?` — Optional route path triggered when the card or circular action button is tapped.

---

### 3. `RecentlyViewedItemEntity`
Represents an item viewed recently by the user.
- **`id`**: `String` — Unique entry identifier.
- **`product`**: `ShopProductEntity` — Reuses the canonical domain entity from `lib/features/home/domain/entities/shop_product_entity.dart`.
- **`viewedAt`**: `DateTime` — Timestamp of inspection.

---

### 4. `OrderStatsEntity`
Represents the post-purchase order volume metrics shown in My Activity.
- **`orderedCount`**: `int` — Count of total placed orders (`12`).
- **`receivedCount`**: `int` — Count of received orders (`7`).
- **`toReceiveCount`**: `int` — Count of in-transit/pending orders (`5`).

---

### 5. `CategorySpendingEntity`
Represents spending in a specific shopping category for the active month.
- **`id`**: `String` — Unique category ID.
- **`name`**: `String` — Category label (`"Clothing"`, `"Lingerie"`, `"Shoes"`, `"Bags"`).
- **`amount`**: `double` — Dollar expenditure (`183.00`, `92.00`, `47.00`, `43.00`).
- **`colorTokenKey`**: `String` — Identifier for matching `AppColors` token (`'chartBlue'`, `'chartGreen'`, `'chartOrange'`, `'chartRed'`).

---

### 6. `ActivitySummaryEntity`
Represents the financial activity summary for a given month (Screen 64).
- **`month`**: `String` — Active month name (e.g., `"April"`).
- **`year`**: `int` — Year (e.g., `2026`).
- **`totalAmount`**: `double` — Sum of category expenditures (`365.00`).
- **`categories`**: `List<CategorySpendingEntity>` — Proportional category spending list.
- **`orderStats`**: `OrderStatsEntity` — Aggregated order counts.

---

### 7. `VoucherEntity`
Represents a discount reward voucher (Screens 82, 83).
- **`id`**: `String` — Unique voucher code/ID.
- **`title`**: `String` — Source/title (`"From Customer Care"`, `"First Purchase"`, `"Loyal Customer"`).
- **`subtitle`**: `String` — Discount terms (`"15% off your next purchase"`, `"5% off for your next order"`).
- **`validUntil`**: `String` — Formatted expiration date string (`"5.16.20"`, `"6.20.20"`).
- **`isExpiring`**: `bool` — `true` if expiration is imminent (triggers Screen 83 red alert styling).
- **`daysLeft`**: `int` — Remaining days before expiration (e.g., `3`).
- **`iconType`**: `String` — Icon key (`'badge'`, `'bag'`, `'heart'`).

---

### 8. `RewardMilestoneEntity`
Represents a gamified milestone achievement (Screen 84).
- **`id`**: `String` — Unique achievement ID.
- **`title`**: `String` — Achievement name (`"First Purchase"`, `"Loyal Customer"`, `"Review Maker"`, `"Big Soul"`, `"Cloth Expert"`, `"10+ Orders"`).
- **`description`**: `String` — Milestone explanation copy text.
- **`iconType`**: `String` — Identifier for badge graphic (`'bag'`, `'heart'`, `'star'`, `'cloud'`, `'shirt'`, `'smile'`).
- **`isEarned`**: `bool` — `true` if unlocked (renders `VerifiedCheckBadge` on top-right).

---

### 9. `StoryEntity`
Represents a creator live stream or social post on Profile Home.
- **`id`**: `String` — Unique story ID.
- **`creatorName`**: `String` — Name of creator.
- **`imageUrl`**: `String` — Path to creator image in `assets/images/`.
- **`isLive`**: `bool` — Whether the story is currently live streaming (displays red "Live" pill).

---

## Enums

```dart
/// Announcement banner states on Profile Home (Screens 62, 81, 85)
enum ProfileAnnouncementType {
  regular,
  rewardEarned,
  voucherExpiring,
}

/// Active tab on Rewards Center (Screens 82, 83 vs 84)
enum RewardsTab {
  activeRewards,
  progress,
}
```

---

## Data Models (Data Layer)

All data models extend their respective domain entities and implement:
- `fromJson(Map<String, dynamic> json)`
- `toJson()`
- `fromEntity(Entity entity)`

1. **`UserProfileModel`** extends `UserProfileEntity`
2. **`AnnouncementModel`** extends `AnnouncementEntity`
3. **`RecentlyViewedItemModel`** extends `RecentlyViewedItemEntity`
4. **`OrderStatsModel`** extends `OrderStatsEntity`
5. **`CategorySpendingModel`** extends `CategorySpendingEntity`
6. **`ActivitySummaryModel`** extends `ActivitySummaryEntity`
7. **`VoucherModel`** extends `VoucherEntity`
8. **`RewardMilestoneModel`** extends `RewardMilestoneEntity`
9. **`StoryModel`** extends `StoryEntity`

