import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/orders/orders_injection.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/pages/order_history_page.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/history_item_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initOrdersInjection();
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets(
    'OrderHistoryPage renders without overflow on 360 width',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => const MaterialApp(
            home: OrderHistoryPage(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HistoryItemTile), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );
}
