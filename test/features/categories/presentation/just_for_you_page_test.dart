import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/categories/categories_injection.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/pages/just_for_you_page.dart';
import 'package:flutter_clean_architecture_template/features/categories/presentation/widgets/just_for_you_header.dart';
import 'package:flutter_clean_architecture_template/features/shop/presentation/widgets/shop_product_card.dart';

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
          home: JustForYouPage(),
        );
      },
    );
  }

  testWidgets(
    'JustForYouPage renders header with title and star section',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Verify header widget exists
      expect(find.byType(JustForYouHeader), findsOneWidget);

      // Verify "Categories" title
      expect(find.text('Categories'), findsOneWidget);

      // Verify "Just for you" section header text and star icon
      expect(find.text('Just for you'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    },
  );

  testWidgets(
    'JustForYouPage renders product grid with ShopProductCard items',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Verify ShopProductCard widgets are rendered in the grid
      expect(find.byType(ShopProductCard), findsWidgets);

      // Verify price formatting ($17,00)
      expect(find.text('\$17,00'), findsWidgets);
    },
  );
}
