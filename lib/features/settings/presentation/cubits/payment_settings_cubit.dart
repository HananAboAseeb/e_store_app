import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/payment_card_entity.dart';
import '../../domain/usecases/add_payment_card_usecase.dart';
import '../../domain/usecases/get_payment_cards_usecase.dart';
import '../../domain/usecases/get_payment_history_usecase.dart';
import '../../domain/usecases/update_payment_card_usecase.dart';
import 'payment_settings_state.dart';

class PaymentSettingsCubit extends Cubit<PaymentSettingsState> {
  final GetPaymentCardsUseCase getPaymentCardsUseCase;
  final AddPaymentCardUseCase addPaymentCardUseCase;
  final UpdatePaymentCardUseCase updatePaymentCardUseCase;
  final GetPaymentHistoryUseCase getPaymentHistoryUseCase;

  PaymentSettingsCubit({
    required this.getPaymentCardsUseCase,
    required this.addPaymentCardUseCase,
    required this.updatePaymentCardUseCase,
    required this.getPaymentHistoryUseCase,
  }) : super(const PaymentSettingsState());

  Future<void> loadPaymentData() async {
    emit(state.copyWith(status: PaymentSettingsStatus.loading));
    final cardsResult = await getPaymentCardsUseCase();
    final historyResult = await getPaymentHistoryUseCase();

    cardsResult.fold(
      (failure) => emit(state.copyWith(
        status: PaymentSettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (cards) {
        historyResult.fold(
          (failure) => emit(state.copyWith(
            status: PaymentSettingsStatus.loaded,
            cards: cards,
          )),
          (history) => emit(state.copyWith(
            status: PaymentSettingsStatus.loaded,
            cards: cards,
            history: history,
          )),
        );
      },
    );
  }

  void toggleViewMode() {
    final newMode = state.viewMode == PaymentViewMode.cards
        ? PaymentViewMode.history
        : PaymentViewMode.cards;
    emit(state.copyWith(viewMode: newMode));
  }

  Future<void> addCard(PaymentCardEntity card) async {
    emit(state.copyWith(status: PaymentSettingsStatus.processing));
    final result = await addPaymentCardUseCase(card);
    result.fold(
      (failure) => emit(state.copyWith(
        status: PaymentSettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (newCard) {
        final updatedCards = List<PaymentCardEntity>.from(state.cards)
          ..add(newCard);
        emit(state.copyWith(
          status: PaymentSettingsStatus.success,
          cards: updatedCards,
        ));
      },
    );
  }

  Future<void> updateCard(PaymentCardEntity card) async {
    emit(state.copyWith(status: PaymentSettingsStatus.processing));
    final result = await updatePaymentCardUseCase(card);
    result.fold(
      (failure) => emit(state.copyWith(
        status: PaymentSettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (updatedCard) {
        final updatedCards = state.cards.map((c) {
          return c.id == updatedCard.id ? updatedCard : c;
        }).toList();
        emit(state.copyWith(
          status: PaymentSettingsStatus.success,
          cards: updatedCards,
        ));
      },
    );
  }
}
