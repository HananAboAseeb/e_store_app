import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/orders/domain/entities/order_entity.dart';
import 'package:flutter_clean_architecture_template/features/orders/orders_injection.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/pages/orders_page.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/order_card.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/orders_header.dart';
import 'package:flutter_clean_architecture_template/features/orders/presentation/widgets/orders_tabs.dart';
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
    'OrdersPage renders Screen 57 matching Figma with OrdersHeader and OrderCards',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const OrdersPage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(OrdersHeader), findsOneWidget);
      expect(find.text('To Recieve'), findsOneWidget);
      expect(find.text('My Orders'), findsOneWidget);

      // Verify Order cards rendered
      expect(find.byType(OrderCard), findsWidgets);
      expect(find.text('Packed'), findsOneWidget);
      expect(find.text('Shipped'), findsOneWidget);
      expect(find.text('Delivered'), findsWidgets);
      expect(find.text('Track'), findsWidgets);
      expect(find.text('Review'), findsWidgets);
    },
  );

  testWidgets(
    'OrdersTabs widget behaves correctly when selecting tabs',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      OrderTab selectedTab = OrderTab.toReceive;

      await tester.pumpWidget(
        buildTestableWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: OrdersTabs(
                  activeTab: selectedTab,
                  onTabSelected: (tab) {
                    setState(() {
                      selectedTab = tab;
                    });
                  },
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('To Pay'), findsOneWidget);
      expect(find.text('To Receive'), findsOneWidget);
      expect(find.text('To Review'), findsOneWidget);

      // Tap 'To Pay'
      await tester.tap(find.text('To Pay'));
      await tester.pumpAndSettle();

      expect(selectedTab, OrderTab.toPay);
    },
  );
}
