import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/voucher_entity.dart';
import '../repositories/checkout_repository.dart';

class GetActiveVouchersUseCase
    implements UseCase<List<VoucherEntity>, NoParam> {
  final CheckoutRepository repository;

  GetActiveVouchersUseCase(this.repository);

  @override
  Future<Either<Failure, List<VoucherEntity>>> call([NoParam? param]) =>
      repository.getActiveVouchers();
}
