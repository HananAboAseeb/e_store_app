import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/checkout/checkout_injection.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/checkout_app_bar.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/checkout_bottom_bar.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/checkout_contact_info_card.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/checkout_items_section.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/checkout_shipping_address_card.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/edit_shipping_address_sheet.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/payment_method_preview.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/shipping_options_section.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/voucher_bottom_sheet.dart';
import 'package:flutter_clean_architecture_template/features/checkout/presentation/widgets/voucher_ticket_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initCheckoutInjection();
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
    'CheckoutPage renders Screen 47 with app bar, address, contact, items, shipping options, and pay bar',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CheckoutPage()));
      await tester.pumpAndSettle();

      // Verify App Bar
      expect(find.byType(CheckoutAppBar), findsOneWidget);
      expect(find.text('Payment'), findsOneWidget);

      // Verify Address & Contact Cards
      expect(find.byType(CheckoutShippingAddressCard), findsOneWidget);
      expect(find.text('Shipping Address'), findsOneWidget);
      expect(find.byType(CheckoutContactInfoCard), findsOneWidget);
      expect(find.text('Contact Information'), findsOneWidget);

      // Verify Items Section
      expect(find.byType(CheckoutItemsSection), findsOneWidget);
      expect(find.text('Items'), findsOneWidget);
      expect(find.text('Add Voucher'), findsOneWidget);

      // Verify Shipping Options
      expect(find.byType(ShippingOptionsSection), findsOneWidget);
      expect(find.text('Shipping Options'), findsOneWidget);
      expect(find.text('Standard'), findsOneWidget);
      expect(find.text('Express'), findsOneWidget);

      // Verify Payment Method Preview
      expect(find.byType(PaymentMethodPreview), findsOneWidget);
      expect(find.text('Payment Method'), findsOneWidget);
      expect(find.text('Card'), findsOneWidget);
      expect(find.text('Paypal'), findsOneWidget);

      // Verify Bottom Bar
      expect(find.byType(CheckoutBottomBar), findsOneWidget);
      expect(find.text('Pay'), findsOneWidget);
    },
  );

  testWidgets(
    'Selecting shipping option toggles selection and updates total',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CheckoutPage()));
      await tester.pumpAndSettle();

      // Tap Express option ($12.00)
      await tester.tap(find.text('Express'));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // Verify Express total ($34.00 items + $12.00 = $46.00)
      expect(find.text('\$46.00'), findsOneWidget);
    },
  );

  testWidgets(
    'Applying voucher opens sheet (Screen 48), applies voucher, and displays discount badge (Screen 49)',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CheckoutPage()));
      await tester.pumpAndSettle();

      // Tap "Add Voucher"
      await tester.tap(find.text('Add Voucher'));
      await tester.pumpAndSettle();

      // Verify Voucher Bottom Sheet (Screen 48)
      expect(find.byType(VoucherBottomSheet), findsOneWidget);
      expect(find.text('Active Vouchers'), findsOneWidget);
      expect(find.byType(VoucherTicketCard), findsNWidgets(2));
      expect(find.text('From Customer Care'), findsOneWidget);
      expect(find.text('First Purchase'), findsOneWidget);

      // Tap Apply on the First Purchase (5%) voucher
      final applyButtons = find.text('Apply');
      await tester.tap(applyButtons.last);
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();

      // Verify sheet closed and voucher badge rendered (Screen 49)
      expect(find.byType(VoucherBottomSheet), findsNothing);
      expect(find.text('5% Discount'), findsOneWidget);

      // Tap ✕ on voucher badge to remove voucher
      await tester.tap(find.byIcon(Icons.close).last);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // Verify reverted back to Screen 47 (Add Voucher button visible)
      expect(find.text('Add Voucher'), findsOneWidget);
      expect(find.text('5% Discount'), findsNothing);
    },
  );

  testWidgets(
    'Tapping address edit button opens EditShippingAddressSheet (Screen 50)',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const CheckoutPage()));
      await tester.pumpAndSettle();

      // Tap edit icon on shipping address card
      final editIcon = find.descendant(
        of: find.byType(CheckoutShippingAddressCard),
        matching: find.byIcon(Icons.edit),
      );
      await tester.tap(editIcon);
      await tester.pumpAndSettle();

      // Verify Edit Shipping Address Sheet (Screen 50)
      expect(find.byType(EditShippingAddressSheet), findsOneWidget);
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('Address'), findsOneWidget);
      expect(find.text('Town / City'), findsOneWidget);
      expect(find.text('Postcode'), findsOneWidget);

      // Tap close button on sheet
      final closeButton = find.descendant(
        of: find.byType(EditShippingAddressSheet),
        matching: find.byIcon(Icons.close),
      );
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Verify sheet dismissed
      expect(find.byType(EditShippingAddressSheet), findsNothing);
    },
  );
}
