import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/orders/orders_injection.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/order_tracking_timeline.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/orders_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initOrdersInjection();
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
    'OrderTrackingPage renders progress timeline (Screen 59) for in-progress order',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestableWidget(const OrderTrackingPage(orderId: 'order-1')),
      );
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(OrdersHeader), findsOneWidget);
      expect(find.text('To Receive'), findsOneWidget);

      // Verify Timeline
      expect(find.byType(OrderTrackingTimeline), findsOneWidget);
      expect(find.text('Packed'), findsOneWidget);
      expect(find.text('On the Way to Logistic Facility'), findsOneWidget);
      expect(find.text('Arrived at Logistic Facility'), findsOneWidget);
    },
  );

  testWidgets(
    'OrderTrackingPage renders failed milestone with Learn more button (Screen 61) for failed attempt order',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestableWidget(const OrderTrackingPage(orderId: 'order-3')),
      );
      await tester.pumpAndSettle();

      // Verify Failed Step
      expect(
        find.text('Attempt to deliver your parcel was not successful'),
        findsOneWidget,
      );
      expect(find.text('Learn more'), findsOneWidget);
    },
  );
}
