import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/delete_account_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  SettingsCubit({
    required this.deleteAccountUseCase,
  }) : super(const SettingsState());

  Future<void> deleteAccount() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await deleteAccountUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: SettingsStatus.accountDeleted)),
    );
  }
}
