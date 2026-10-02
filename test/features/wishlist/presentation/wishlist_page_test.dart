import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/home/presentation/widgets/most_popular_section.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/wishlist_empty_view.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/wishlist_header.dart';
import 'package:flutter_clean_architecture_template/features/wishlist/presentation/widgets/wishlist_item_row.dart';
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
    'WishlistPage renders populated wishlist (Screen 38) with header and items',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const WishlistPage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(WishlistHeader), findsOneWidget);
      expect(find.text('Wishlist'), findsOneWidget);

      // Verify Items
      expect(find.byType(WishlistItemRow), findsWidgets);
    },
  );

  testWidgets(
    'WishlistPage renders empty wishlist view (Screen 38-Empty) when all items are removed',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const WishlistPage()));
      await tester.pumpAndSettle();

      final cubit = tester.element(find.byType(Scaffold)).read<WishlistCubit>();
      await tester.runAsync(() async {
        await cubit.removeItem('wl_1');
        await cubit.removeItem('wl_2');
        await cubit.removeItem('wl_3');
        await cubit.removeItem('wl_4');
        await cubit.removeItem('wl_5');
      });
      await tester.pumpAndSettle();

      // Verify Empty State
      expect(find.byType(WishlistEmptyView), findsOneWidget);
      expect(find.text('Your Wishlist is Empty'), findsOneWidget);
      expect(find.byType(MostPopularSection), findsOneWidget);
    },
  );
}
