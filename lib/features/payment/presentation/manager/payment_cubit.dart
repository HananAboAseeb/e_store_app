import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/use_cases/use_case.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../../domain/usecases/get_payment_methods_usecase.dart';
import '../../domain/usecases/process_payment_usecase.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;

  List<PaymentMethodEntity> _cachedMethods = [];
  PaymentMethodEntity? _selectedMethod;
  PaymentMethodEntity? _lastAttemptedMethod;
  double _lastAttemptedAmount = 0.0;

  PaymentCubit({
    required this.getPaymentMethodsUseCase,
    required this.processPaymentUseCase,
  }) : super(PaymentInitial());

  List<PaymentMethodEntity> get cachedMethods => _cachedMethods;
  PaymentMethodEntity? get selectedMethod => _selectedMethod;

  Future<void> loadPaymentMethods() async {
    debugPrint('🔵 [PaymentCubit] loadPaymentMethods called');
    emit(PaymentLoadingMethods());
    try {
      final result = await getPaymentMethodsUseCase(NoParam());
      debugPrint('🔵 [PaymentCubit] result received: $result');
      result.fold(
        (failure) {
          debugPrint('🔴 [PaymentCubit] FAILURE: ${failure.message}');
          emit(PaymentError(message: failure.message));
        },
        (methods) {
          debugPrint('🟢 [PaymentCubit] SUCCESS: ${methods.length} methods');
          _cachedMethods = methods;
          _selectedMethod = methods.firstWhere(
            (m) => m.isDefault,
            orElse: () => methods.isNotEmpty
                ? methods.first
                : const PaymentMethodEntity(
                    id: 'default',
                    type: PaymentMethodType.card,
                  ),
          );
          emit(PaymentMethodSelection(
            methods: _cachedMethods,
            selectedMethod: _selectedMethod,
          ));
          debugPrint('🟢 [PaymentCubit] Emitted PaymentMethodSelection');
        },
      );
    } catch (e, st) {
      debugPrint('🔴 [PaymentCubit] EXCEPTION: $e');
      debugPrint('🔴 [PaymentCubit] STACK: $st');
      emit(PaymentError(message: e.toString()));
    }
  }

  void selectPaymentMethod(PaymentMethodEntity method) {
    _selectedMethod = method;
    emit(PaymentMethodSelection(
      methods: _cachedMethods,
      selectedMethod: _selectedMethod,
    ));
  }

  Future<void> processPayment(PaymentMethodEntity method, double amount) async {
    _lastAttemptedMethod = method;
    _lastAttemptedAmount = amount;
    emit(PaymentProcessing(method: method, amount: amount));

    final result = await processPaymentUseCase(
      ProcessPaymentParams(method: method, amount: amount),
    );

    result.fold(
      (failure) => emit(PaymentFailureState(
        method: method,
        amount: amount,
        message: failure.message,
      )),
      (paymentResult) {
        if (paymentResult.status == PaymentStatus.success) {
          emit(PaymentSuccessState(result: paymentResult));
        } else {
          emit(PaymentFailureState(
            method: method,
            amount: amount,
            message: paymentResult.message,
          ));
        }
      },
    );
  }

  Future<void> retryPayment() async {
    if (_lastAttemptedMethod != null) {
      await processPayment(_lastAttemptedMethod!, _lastAttemptedAmount);
    }
  }

  void changePaymentMethod() {
    emit(PaymentMethodSelection(
      methods: _cachedMethods,
      selectedMethod: _selectedMethod,
    ));
  }

  void reset() {
    _selectedMethod = null;
    _lastAttemptedMethod = null;
    _lastAttemptedAmount = 0.0;
    emit(PaymentInitial());
  }
}
