import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/shop/shop_injection.dart';
import 'package:flutter_clean_architecture_template/features/shop/presentation/pages/shop_page.dart';
import 'package:flutter_clean_architecture_template/features/shop/presentation/widgets/shop_category_grid.dart';
import 'package:flutter_clean_architecture_template/features/shop/presentation/widgets/shop_product_card.dart';

void main() {
  setUpAll(() {
    initShop();
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
          home: ShopPage(),
        );
      },
    );
  }

  testWidgets('ShopPage renders Shop title, categories, and products',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    // Verify "Shop" title in App Bar
    expect(find.text('Shop'), findsOneWidget);

    // Verify category grid is rendered
    expect(find.byType(ShopCategoryGrid), findsOneWidget);

    // Verify "All Items" section title
    expect(find.text('All Items'), findsOneWidget);

    // Verify product cards are displayed
    expect(find.byType(ShopProductCard), findsWidgets);
  });

  testWidgets('Tapping gear filter icon opens FilterModalSheet',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    // Find the settings/gear icon button
    final filterButton = find.byIcon(Icons.settings_outlined).first;
    expect(filterButton, findsOneWidget);

    // Tap the filter button to open modal
    await tester.tap(filterButton);
    await tester.pumpAndSettle();

    // Verify modal sheet opened with "Filter" title and "Apply" button
    expect(find.text('Filter'), findsOneWidget);
    expect(find.text('Apply'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
  });
}
