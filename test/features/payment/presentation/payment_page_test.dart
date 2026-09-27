import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/di/injection_container.dart';
import 'package:flutter_clean_architecture_template/core/errors/failures.dart';
import 'package:flutter_clean_architecture_template/features/payment/domain/entities/payment_method_entity.dart';
import 'package:flutter_clean_architecture_template/features/payment/domain/entities/payment_result_entity.dart';
import 'package:flutter_clean_architecture_template/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:flutter_clean_architecture_template/features/payment/domain/usecases/process_payment_usecase.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/manager/payment_cubit.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/pages/payment_page.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_card_item.dart';
import 'package:flutter_clean_architecture_template/features/payment/presentation/widgets/payment_success_modal.dart';
import 'package:flutter_clean_architecture_template/shared/use_cases/use_case.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetPaymentMethodsUseCase implements GetPaymentMethodsUseCase {
  final List<PaymentMethodEntity> methods;
  MockGetPaymentMethodsUseCase(this.methods);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call([NoParam? param]) async {
    return Right(methods);
  }
}

class MockProcessPaymentUseCase implements ProcessPaymentUseCase {
  final PaymentResultEntity result;
  MockProcessPaymentUseCase(this.result);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<Either<Failure, PaymentResultEntity>> call([ProcessPaymentParams? params]) async {
    return Right(result);
  }
}

void main() {
  setUp(() async {
    await sl.reset();
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

  final testCards = [
    const PaymentMethodEntity(
      id: 'card-1',
      type: PaymentMethodType.card,
      cardBrand: CardBrand.mastercard,
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      cardholderName: 'AMANDA',
      expiryDate: '12/22',
      isDefault: true,
    ),
  ];

  final successResult = PaymentResultEntity(
    id: 'tx-1',
    orderId: 'order-123',
    status: PaymentStatus.success,
    message: 'Your card has been successfully charged',
    amount: 34.00,
    timestamp: DateTime.now(),
  );

  testWidgets('PaymentPage loads methods, renders PaymentMethodSheet and handles tap', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    sl.registerFactory<PaymentCubit>(
      () => PaymentCubit(
        getPaymentMethodsUseCase: MockGetPaymentMethodsUseCase(testCards),
        processPaymentUseCase: MockProcessPaymentUseCase(successResult),
      ),
    );

    await tester.pumpWidget(buildTestableWidget(const PaymentPage(amount: 34.00)));

    // Initially mounts
    await tester.pump();
    expect(find.byType(PaymentPage), findsOneWidget);

    // After async load completes, shows Payment Methods sheet
    await tester.pumpAndSettle();
    expect(find.text('Payment Methods'), findsOneWidget);
    expect(find.byType(PaymentCardItem), findsOneWidget);

    // Tap card to trigger processing
    await tester.tap(find.byType(PaymentCardItem).first);
    await tester.pump();

    // Verify Success modal renders
    await tester.pumpAndSettle();
    expect(find.byType(PaymentSuccessModal), findsOneWidget);
    expect(find.text('Done!'), findsOneWidget);
  });
}
