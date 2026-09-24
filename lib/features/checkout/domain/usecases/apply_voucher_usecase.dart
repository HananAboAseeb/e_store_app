import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/checkout_summary_entity.dart';
import '../repositories/checkout_repository.dart';

class ApplyVoucherUseCase implements UseCase<CheckoutSummaryEntity, String> {
  final CheckoutRepository repository;

  ApplyVoucherUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call([String? voucherId]) =>
      repository.applyVoucher(voucherId ?? '');
}
