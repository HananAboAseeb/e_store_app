import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/pages/my_activity_page.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/pages/rewards_page.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/announcement_card.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/donut_chart.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/month_selector.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/my_orders_tabs.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/order_stats_circles.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/recently_viewed_horizontal_list.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/rewards_tabs.dart';
import 'package:flutter_clean_architecture_template/features/profile/presentation/widgets/stories_section.dart';
import 'package:flutter_clean_architecture_template/features/profile/profile_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initProfile();
  });

  tearDown(() async {
    await sl.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          home: child,
        );
      },
    );
  }

  testWidgets(
    'ProfilePage renders header, greeting, announcement, recently viewed, order tabs, and stories',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const ProfilePage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.text('My Activity'), findsOneWidget);

      // Verify Greeting
      expect(find.text('Hello, Romina!'), findsOneWidget);

      // Verify Announcement
      expect(find.byType(AnnouncementCard), findsOneWidget);
      expect(find.text('Announcement'), findsOneWidget);

      // Verify Recently viewed
      expect(find.byType(RecentlyViewedHorizontalList), findsOneWidget);
      expect(find.text('Recently viewed'), findsOneWidget);

      // Verify My Orders tabs
      expect(find.byType(MyOrdersTabs), findsOneWidget);
      expect(find.text('To Pay'), findsOneWidget);
      expect(find.text('To Recieve'), findsOneWidget);
      expect(find.text('To Review'), findsOneWidget);

      // Verify Stories
      expect(find.byType(StoriesSection), findsOneWidget);
      expect(find.text('Stories'), findsOneWidget);
      expect(find.text('Live'), findsOneWidget);
    },
  );

  testWidgets(
    'MyActivityPage renders month selector, donut chart, category legend, order stats, and CTA',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const MyActivityPage()));
      await tester.pumpAndSettle();

      // Verify Header custom title
      expect(find.text('My Activity'), findsOneWidget);

      // Verify Month Selector
      expect(find.byType(MonthSelector), findsOneWidget);
      expect(find.text('April'), findsOneWidget);

      // Verify Donut Chart & Center Amount
      expect(find.byType(DonutChart), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('\$365,00'), findsOneWidget);

      // Verify Order Stats
      expect(find.byType(OrderStatsCircles), findsOneWidget);
      expect(find.text('Ordered'), findsOneWidget);
      expect(find.text('Recieved'), findsOneWidget);
      expect(find.text('To Recieve'), findsOneWidget);

      // Verify CTA
      expect(find.text('Order History'), findsOneWidget);
    },
  );

  testWidgets(
    'RewardsPage renders active rewards list and toggles to progress milestones grid',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const RewardsPage()));
      await tester.pumpAndSettle();

      // Verify Tabs
      expect(find.byType(RewardsTabs), findsOneWidget);
      expect(find.text('Active Rewards'), findsOneWidget);
      expect(find.text('Progress'), findsOneWidget);

      // Active Rewards list has vouchers
      expect(find.text('From Customer Care'), findsOneWidget);
      expect(find.text('3 days left'),
          findsOneWidget); // Screen 83 expiring voucher
      expect(find.text('First Purchase'), findsOneWidget);

      // Tap Progress tab
      await tester.tap(find.text('Progress'));
      await tester.pumpAndSettle();

      // Verify Progress grid displays milestones
      expect(find.text('Loyal Customer'), findsOneWidget);
      expect(find.text('Review Maker'), findsOneWidget);
      expect(find.text('Big Soul'), findsOneWidget);
    },
  );
}
