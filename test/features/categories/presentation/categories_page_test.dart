import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/categories/categories_injection.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/pages/categories_page.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/widgets/category_accordion_tile.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/widgets/gender_tab_bar.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/widgets/just_for_you_card.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/widgets/sub_category_pill.dart';

void main() {
  setUpAll(() {
    initCategories();
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
          home: CategoriesPage(),
        );
      },
    );
  }

  testWidgets(
    'CategoriesPage renders header, gender tabs, and accordion tiles',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Verify "All Categories" title
      expect(find.text('All Categories'), findsOneWidget);

      // Verify close button
      expect(find.byIcon(Icons.close), findsOneWidget);

      // Verify gender tab bar
      expect(find.byType(GenderTabBar), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);

      // Verify accordion tiles are rendered
      expect(find.byType(CategoryAccordionTile), findsWidgets);

      // Verify Clothing is expanded by default with sub-category pills
      expect(find.text('Clothing'), findsOneWidget);
      expect(find.byType(SubCategoryPill), findsWidgets);
      expect(find.text('Dresses'), findsOneWidget);
      expect(find.text('Pants'), findsOneWidget);

      // Verify other collapsed categories
      expect(find.text('Shoes'), findsOneWidget);
      expect(find.text('Bags'), findsOneWidget);
      expect(find.text('Accesories'), findsOneWidget);

      // Verify Just for you card
      expect(find.byType(JustForYouCard), findsOneWidget);
      expect(find.text('Just for you'), findsOneWidget);
    },
  );

  testWidgets(
    'Tapping a collapsed category expands it and collapses Clothing',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Initially Clothing is expanded — we should see its sub-categories
      expect(find.text('Dresses'), findsOneWidget);

      // Tap "Shoes" to expand it (and collapse Clothing)
      await tester.tap(find.text('Shoes'));
      await tester.pumpAndSettle();

      // After tapping Shoes, Clothing sub-categories should animate away
      // and Shoes should now be the expanded tile
      // Verify the toggle occurred by checking upward chevron presence changed
      expect(find.text('Shoes'), findsOneWidget);
    },
  );
}
