import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter_clean_architecture_template/features/product/presentation/pages/reviews_page.dart';
import 'package:flutter_clean_architecture_template/features/product/presentation/widgets/product_bottom_bar.dart';
import 'package:flutter_clean_architecture_template/features/product/presentation/widgets/product_image_gallery.dart';
import 'package:flutter_clean_architecture_template/features/product/presentation/widgets/product_rating_row.dart';
import 'package:flutter_clean_architecture_template/features/product/product_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initProductInjection();
  });

  tearDownAll(() async {
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
    'ProductDetailsPage renders product title, image gallery, rating, and bottom bar',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestableWidget(
          const ProductDetailsPage(productId: 'caviar-jacket'),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Title
      expect(find.text('Caviar Leather Jacket'), findsOneWidget);

      // Verify Gallery
      expect(find.byType(ProductImageGallery), findsOneWidget);

      // Verify Rating
      expect(find.byType(ProductRatingRow), findsOneWidget);
      expect(find.text('4.7'), findsNWidgets(2)); // in row and in breakdown

      // Verify Bottom Bar
      expect(find.byType(ProductBottomBar), findsOneWidget);
      expect(find.text('Add to Basket'), findsOneWidget);
    },
  );

  testWidgets(
    'ReviewsPage renders header and customer reviews',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestableWidget(
          const ReviewsPage(productId: 'caviar-jacket'),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.text('Reviews'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);

      // Verify Review author
      expect(find.text('Veronica'), findsOneWidget);
    },
  );
}
