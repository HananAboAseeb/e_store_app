import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/cart/cart_injection.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/manager/cart_cubit.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/widgets/cart_bottom_bar.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/widgets/cart_header.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/widgets/empty_cart_state.dart';
import 'package:flutter_clean_architecture_template/features/cart/presentation/widgets/shipping_address_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initCart();
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
    'CartPage renders populated cart (Screen 44) with header, address, and checkout button',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CartPage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(CartHeader), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // 2 items in initial mock

      // Verify Shipping Address
      expect(find.byType(ShippingAddressCard), findsOneWidget);
      expect(find.text('Shipping Address'), findsOneWidget);

      // Verify Bottom Bar
      expect(find.byType(CartBottomBar), findsOneWidget);
      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('\$34,00'), findsOneWidget);
    },
  );

  testWidgets(
    'CartPage renders empty cart state when cart is cleared',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CartPage()));
      await tester.pumpAndSettle();

      // Clear the cart via cubit
      final cubit = tester.element(find.byType(Scaffold)).read<CartCubit>();
      cubit.clearCart();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Verify Empty Cart State
      expect(find.byType(EmptyCartState), findsOneWidget);
      expect(find.text('Your Cart is Empty'), findsOneWidget);

      // Verify Disabled Checkout
      expect(find.text('\$0,00'), findsOneWidget);
    },
  );
}
