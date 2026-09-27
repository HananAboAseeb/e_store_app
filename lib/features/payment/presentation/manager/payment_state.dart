import 'package:equatable/equatable.dart';

import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/payment_result_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoadingMethods extends PaymentState {}

class PaymentMethodSelection extends PaymentState {
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selectedMethod;

  const PaymentMethodSelection({
    required this.methods,
    this.selectedMethod,
  });

  @override
  List<Object?> get props => [methods, selectedMethod];

  PaymentMethodSelection copyWith({
    List<PaymentMethodEntity>? methods,
    PaymentMethodEntity? selectedMethod,
  }) {
    return PaymentMethodSelection(
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
    );
  }
}

class PaymentProcessing extends PaymentState {
  final PaymentMethodEntity method;
  final double amount;

  const PaymentProcessing({
    required this.method,
    required this.amount,
  });

  @override
  List<Object?> get props => [method, amount];
}

class PaymentFailureState extends PaymentState {
  final PaymentMethodEntity method;
  final double amount;
  final String message;

  const PaymentFailureState({
    required this.method,
    required this.amount,
    required this.message,
  });

  @override
  List<Object?> get props => [method, amount, message];
}

class PaymentSuccessState extends PaymentState {
  final PaymentResultEntity result;

  const PaymentSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}
