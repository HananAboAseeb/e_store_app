import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/pages/search_page.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/widgets/search_chip.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/widgets/search_discover_carousel.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/widgets/search_header.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/widgets/search_history_section.dart';
import 'package:flutter_clean_architecture_template/features/search/presentation/widgets/search_recommendations_section.dart';
import 'package:flutter_clean_architecture_template/features/search/search_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initSearch();
  });

  tearDownAll(() async {
    await sl.reset();
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          home: SearchPage(),
        );
      },
    );
  }

  testWidgets(
    'SearchPage renders Search title, input field, history chips, and recommendations',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Verify "Search" title and hint text
      expect(find.text('Search'), findsNWidgets(2));

      // Verify SearchHeader
      expect(find.byType(SearchHeader), findsOneWidget);

      // Verify SearchHistorySection
      expect(find.byType(SearchHistorySection), findsOneWidget);
      expect(find.text('Search History'), findsOneWidget);
      expect(find.text('Socks'), findsOneWidget);
      expect(find.text('Red Dress'), findsOneWidget);

      // Verify SearchRecommendationsSection
      expect(find.byType(SearchRecommendationsSection), findsOneWidget);
      expect(find.text('Recommendations'), findsOneWidget);
      expect(find.text('Skirt'), findsOneWidget);
      expect(find.text('Accessories'), findsOneWidget);

      // Verify SearchDiscoverCarousel
      expect(find.byType(SearchDiscoverCarousel), findsOneWidget);
      expect(find.text('Discover'), findsOneWidget);

      // Verify chips count
      expect(find.byType(SearchChip), findsWidgets);
    },
  );

  testWidgets(
    'Tapping trash icon clears history chips',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Socks'), findsOneWidget);

      // Tap trash icon
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // History section is cleared
      expect(find.text('Socks'), findsNothing);
    },
  );
}
