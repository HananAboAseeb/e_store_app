import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/profile_enums.dart';
import '../../../domain/entities/reward_milestone_entity.dart';
import '../../../domain/entities/voucher_entity.dart';

abstract class RewardsState extends Equatable {
  const RewardsState();

  @override
  List<Object?> get props => [];
}

class RewardsInitial extends RewardsState {}

class RewardsLoading extends RewardsState {}

class RewardsLoaded extends RewardsState {
  final RewardsTab activeTab;
  final List<VoucherEntity> vouchers;
  final List<RewardMilestoneEntity> rewards;
  final bool hasExpiringVoucher;

  const RewardsLoaded({
    this.activeTab = RewardsTab.activeRewards,
    required this.vouchers,
    required this.rewards,
    required this.hasExpiringVoucher,
  });

  RewardsLoaded copyWith({
    RewardsTab? activeTab,
    List<VoucherEntity>? vouchers,
    List<RewardMilestoneEntity>? rewards,
    bool? hasExpiringVoucher,
  }) {
    return RewardsLoaded(
      activeTab: activeTab ?? this.activeTab,
      vouchers: vouchers ?? this.vouchers,
      rewards: rewards ?? this.rewards,
      hasExpiringVoucher: hasExpiringVoucher ?? this.hasExpiringVoucher,
    );
  }

  @override
  List<Object?> get props => [
        activeTab,
        vouchers,
        rewards,
        hasExpiringVoucher,
      ];
}

class RewardsError extends RewardsState {
  final Failure failure;

  const RewardsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
