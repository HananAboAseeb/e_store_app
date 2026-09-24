import 'package:equatable/equatable.dart';

import '../../domain/entities/checkout_summary_entity.dart';
import '../../domain/entities/voucher_entity.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutLoaded extends CheckoutState {
  final CheckoutSummaryEntity summary;
  final List<VoucherEntity> activeVouchers;

  const CheckoutLoaded({
    required this.summary,
    this.activeVouchers = const [],
  });

  bool get isVoucherApplied => summary.appliedVoucher != null;

  CheckoutLoaded copyWith({
    CheckoutSummaryEntity? summary,
    List<VoucherEntity>? activeVouchers,
  }) {
    return CheckoutLoaded(
      summary: summary ?? this.summary,
      activeVouchers: activeVouchers ?? this.activeVouchers,
    );
  }

  @override
  List<Object?> get props => [summary, activeVouchers];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}
