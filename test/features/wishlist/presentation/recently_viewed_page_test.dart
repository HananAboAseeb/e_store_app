import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/shop/presentation/widgets/shop_product_card.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/pages/recently_viewed_page.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/recently_viewed_calendar.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/recently_viewed_date_tabs.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/recently_viewed_header.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/wishlist_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initWishlist();
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
    'RecentlyViewedPage renders header, date tabs, and product cards (Screen 39)',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const RecentlyViewedPage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(RecentlyViewedHeader), findsOneWidget);
      expect(find.text('Recently viewed'), findsOneWidget);

      // Verify Date Tabs
      expect(find.byType(RecentlyViewedDateTabs), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Yesterday'), findsOneWidget);

      // Verify Product Grid
      expect(find.byType(ShopProductCard), findsWidgets);
    },
  );

  testWidgets(
    'RecentlyViewedPage toggles calendar on chevron tap and collapses (Screens 40 & 41)',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const RecentlyViewedPage()));
      await tester.pumpAndSettle();

      // Initially calendar is not shown
      expect(find.byType(RecentlyViewedCalendar), findsNothing);

      // Tap chevron down button
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Calendar is now expanded (Screen 40)
      expect(find.byType(RecentlyViewedCalendar), findsOneWidget);
      expect(find.text('April'), findsOneWidget);

      // Tap day 18 in the calendar
      await tester.tap(find.text('18'));
      await tester.pumpAndSettle();

      // Calendar collapses and dynamic tab is active, replacing Yesterday (Screen 41)
      expect(find.byType(RecentlyViewedCalendar), findsNothing);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('April, 18'), findsOneWidget);
      expect(find.text('Yesterday'), findsNothing);
    },
  );
}
