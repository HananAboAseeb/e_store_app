import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/about_shopx_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/currency_selection_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/language_selection_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/payment_settings_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/shipping_address_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/sizes_selection_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/pages/your_profile_page.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/widgets/delete_account_dialog.dart';
import 'package:flutter_clean_architecture_template/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:flutter_clean_architecture_template/features/settings/settings_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    initSettingsInjection();
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
          theme: ThemeData(useMaterial3: false),
          home: child,
        );
      },
    );
  }

  testWidgets(
    'SettingsPage renders Personal, Shop, and Account sections, Delete button, and Version',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const SettingsPage()));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.byType(SettingsSectionHeader), findsNWidgets(3));
      expect(find.text('Personal'), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget);
      expect(find.text('Account'), findsOneWidget);

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Shipping Address'), findsOneWidget);
      expect(find.text('Payment Methods'), findsOneWidget);
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('Currency'), findsOneWidget);
      expect(find.text('Sizes'), findsOneWidget);
      expect(find.text('Terms and Conditions'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('About ShopX'), findsOneWidget);

      expect(find.text('Delete My Account'), findsOneWidget);
      expect(find.text('ShopX'), findsOneWidget);
      expect(find.text('Version 1.0 June, 2026'), findsOneWidget);
    },
  );

  testWidgets(
    'YourProfilePage renders user credentials and Edit Information button',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const YourProfilePage()));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Your Profile'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Romina'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('gmail@example.com'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Edit Information'), findsOneWidget);
    },
  );

  testWidgets(
    'PaymentSettingsPage renders card carousel and toggles between PayPal and History',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const PaymentSettingsPage()));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Payment Methods'), findsOneWidget);
      expect(find.text('Card'), findsOneWidget);

      // Default mode shows PayPal
      expect(find.text('PayPal'), findsOneWidget);
      expect(find.text('There is no account yet'), findsOneWidget);

      // Tap history toggle button
      await tester.tap(find.byIcon(Icons.history));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      // History mode shows Payment History
      expect(find.text('Payment History'), findsOneWidget);
      expect(find.text('Order #92287157'), findsWidgets);
    },
  );

  testWidgets(
    'ShippingAddressPage renders read-only view and toggles to edit mode',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const ShippingAddressPage()));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Shipping Address'), findsOneWidget);
      expect(find.text('Address'), findsOneWidget);
      expect(find.text('Town / City'), findsOneWidget);
      expect(find.text('Postcode'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);

      // In read-only mode, shows Edit Information
      expect(find.text('Edit Information'), findsOneWidget);

      // Tap Edit Information to toggle
      await tester.tap(find.text('Edit Information'));
      await tester.pumpAndSettle();

      // Now in edit mode, shows Save Changes
      expect(find.text('Save Changes'), findsOneWidget);
    },
  );

  testWidgets(
    'Preferences Pages render selection tiles correctly',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Language page
      await tester
          .pumpWidget(buildTestableWidget(const LanguageSelectionPage()));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Français'), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);

      // Currency page
      await tester
          .pumpWidget(buildTestableWidget(const CurrencySelectionPage()));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(find.text('Currency'), findsOneWidget);
      expect(find.text('\$ USD'), findsOneWidget);
      expect(find.text('€ EURO'), findsOneWidget);

      // Sizes page
      await tester.pumpWidget(buildTestableWidget(const SizesSelectionPage()));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
      expect(find.text('Sizes'), findsOneWidget);
      expect(find.text('US'), findsOneWidget);
      expect(find.text('EU'), findsOneWidget);
      expect(find.text('UK'), findsOneWidget);
    },
  );

  testWidgets(
    'DeleteAccountDialog renders warning message with Cancel and Delete actions',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const DeleteAccountDialog()));
      await tester.pumpAndSettle();

      expect(find.byType(WarningExclamationBadge), findsOneWidget);
      expect(
          find.text('You are going to delete\nyour account'), findsOneWidget);
      expect(
          find.text("You won't be able to restore your data"), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    },
  );

  testWidgets(
    'AboutShopXPage renders brand header, description, and contact email',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget(const AboutShopXPage()));
      await tester.pumpAndSettle();

      expect(find.text('About ShopX'), findsOneWidget);
      expect(find.textContaining('facilitate the development'), findsOneWidget);
      expect(find.text('contact.blacksidedesign@gmail.com'), findsOneWidget);
    },
  );
}
