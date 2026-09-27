import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_failure_modal.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_processing_modal.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_success_modal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          home: Scaffold(body: child),
        );
      },
    );
  }

  testWidgets(
    'PaymentProcessingModal renders spinner and text',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        buildTestableWidget(const PaymentProcessingModal()),
      );
      await tester.pump();

      expect(find.text('Payment in Progress'), findsOneWidget);
      expect(find.text('Please, wait a few moments'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'PaymentFailureModal renders error details and handles button taps',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool tryAgainPressed = false;
      bool changePressed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          PaymentFailureModal(
            onTryAgain: () => tryAgainPressed = true,
            onChange: () => changePressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("We couldn't proceed\nyour payment"), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
      expect(find.text('Change'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      await tester.pumpAndSettle();
      expect(tryAgainPressed, isTrue);

      await tester.tap(find.text('Change'));
      await tester.pumpAndSettle();
      expect(changePressed, isTrue);
    },
  );

  testWidgets(
    'PaymentSuccessModal renders success checkmark and handles track order tap',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      bool trackOrderPressed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          PaymentSuccessModal(
            onTrackOrder: () => trackOrderPressed = true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Done!'), findsOneWidget);
      expect(
          find.text('Your card has been successfully charged'), findsOneWidget);
      expect(find.text('Track your Order'), findsOneWidget);

      await tester.tap(find.text('Track your Order'));
      await tester.pumpAndSettle();
      expect(trackOrderPressed, isTrue);
    },
  );
}
