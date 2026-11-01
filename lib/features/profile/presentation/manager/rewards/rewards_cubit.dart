import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/profile_enums.dart';
import '../../../domain/usecases/get_rewards_usecase.dart';
import '../../../domain/usecases/get_vouchers_usecase.dart';
import 'rewards_state.dart';

class RewardsCubit extends Cubit<RewardsState> {
  final GetVouchersUseCase getVouchersUseCase;
  final GetRewardsUseCase getRewardsUseCase;

  RewardsCubit({
    required this.getVouchersUseCase,
    required this.getRewardsUseCase,
  }) : super(RewardsInitial());

  Future<void> loadRewards() async {
    emit(RewardsLoading());

    final vouchersResult = await getVouchersUseCase();
    final rewardsResult = await getRewardsUseCase();

    vouchersResult.fold(
      (failure) => emit(RewardsError(failure)),
      (vouchers) {
        rewardsResult.fold(
          (failure) => emit(RewardsError(failure)),
          (rewards) {
            final hasExpiring = vouchers.any((v) => v.isExpiring);
            emit(RewardsLoaded(
              activeTab: RewardsTab.activeRewards,
              vouchers: vouchers,
              rewards: rewards,
              hasExpiringVoucher: hasExpiring,
            ));
          },
        );
      },
    );
  }

  void switchTab(RewardsTab tab) {
    if (state is RewardsLoaded) {
      final current = state as RewardsLoaded;
      emit(current.copyWith(activeTab: tab));
    }
  }
}
