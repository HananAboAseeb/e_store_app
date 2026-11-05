import 'package:equatable/equatable.dart';

import '../../domain/entities/payment_card_entity.dart';
import '../../domain/entities/payment_history_entity.dart';

enum PaymentSettingsStatus {
  initial,
  loading,
  loaded,
  processing,
  success,
  failure
}

enum PaymentViewMode { cards, history }

class PaymentSettingsState extends Equatable {
  final PaymentSettingsStatus status;
  final PaymentViewMode viewMode;
  final List<PaymentCardEntity> cards;
  final List<PaymentHistoryEntity> history;
  final String? errorMessage;

  const PaymentSettingsState({
    this.status = PaymentSettingsStatus.initial,
    this.viewMode = PaymentViewMode.cards,
    this.cards = const [],
    this.history = const [],
    this.errorMessage,
  });

  PaymentSettingsState copyWith({
    PaymentSettingsStatus? status,
    PaymentViewMode? viewMode,
    List<PaymentCardEntity>? cards,
    List<PaymentHistoryEntity>? history,
    String? errorMessage,
  }) {
    return PaymentSettingsState(
      status: status ?? this.status,
      viewMode: viewMode ?? this.viewMode,
      cards: cards ?? this.cards,
      history: history ?? this.history,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, viewMode, cards, history, errorMessage];
}
