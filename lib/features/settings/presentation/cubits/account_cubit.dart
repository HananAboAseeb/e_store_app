import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_account_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  AccountCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(const AccountState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: AccountStatus.loading));
    final result = await getProfileUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountStatus.failure,
        errorMessage: failure.message,
      )),
      (profile) => emit(state.copyWith(
        status: AccountStatus.loaded,
        userProfile: profile,
      )),
    );
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  Future<void> updateProfile(UserAccountEntity updated) async {
    emit(state.copyWith(status: AccountStatus.updating));
    final result = await updateProfileUseCase(updated);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AccountStatus.failure,
        errorMessage: failure.message,
      )),
      (profile) => emit(state.copyWith(
        status: AccountStatus.updateSuccess,
        userProfile: profile,
        isEditing: false,
      )),
    );
  }
}
