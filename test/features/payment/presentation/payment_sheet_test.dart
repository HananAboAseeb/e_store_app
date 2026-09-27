import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/features/payment/domain/entities/payment_method_entity.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/add_card_button.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_card_item.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_method_sheet.dart';
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

  final mockCards = [
    const PaymentMethodEntity(
      id: 'card-1',
      type: PaymentMethodType.card,
      cardBrand: CardBrand.mastercard,
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      cardholderName: 'AMANDA',
      expiryDate: '12/22',
      isDefault: true,
    ),
    const PaymentMethodEntity(
      id: 'card-2',
      type: PaymentMethodType.card,
      cardBrand: CardBrand.visa,
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      cardholderName: 'AMANDA',
      expiryDate: '12/22',
      isDefault: false,
    ),
  ];

  testWidgets(
    'PaymentMethodSheet renders title, close button, cards and add card button',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      PaymentMethodEntity? selected;

      await tester.pumpWidget(
        buildTestableWidget(
          PaymentMethodSheet(
            methods: mockCards,
            onMethodSelected: (method) {
              selected = method;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Payment Methods'), findsOneWidget);
      expect(find.byType(PaymentCardItem), findsWidgets);
      expect(find.text('AMANDA'), findsWidgets);

      // Scroll horizontal list to reveal AddCardButton
      await tester.drag(find.byType(ListView), const Offset(-300, 0));
      await tester.pumpAndSettle();
      expect(find.byType(AddCardButton), findsOneWidget);

      // Scroll back and tap first card
      await tester.drag(find.byType(ListView), const Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PaymentCardItem).first);
      await tester.pumpAndSettle();

      expect(selected, isNotNull);
      expect(selected?.cardBrand, equals(CardBrand.mastercard));
    },
  );
}
