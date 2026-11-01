import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/voucher_entity.dart';
import '../repositories/profile_repository.dart';

class GetVouchersUseCase implements UseCase<List<VoucherEntity>, NoParam> {
  final ProfileRepository repository;

  GetVouchersUseCase(this.repository);

  @override
  Future<Either<Failure, List<VoucherEntity>>> call([NoParam? param]) =>
      repository.getVouchers();
}
