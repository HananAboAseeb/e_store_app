import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/mixin/cancelable_safe_cubit_mixin.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState>
    with CancelableSafeCubitMixin<UserState> {
  final GetUsersUseCase _getUsersUseCase;

  UserCubit(this._getUsersUseCase)
      : super(UserInitial());

  Future<void> loadData() async {
    safeEmit(UserLoading());

    final result = await runCancelable(
      _getUsersUseCase.call(),
    );

    if (result == null) return;

    result.fold(
      (failure) => safeEmit(UserError(failure.message)),
      (items) => safeEmit(UserLoaded(items)),
    );
  }
}
