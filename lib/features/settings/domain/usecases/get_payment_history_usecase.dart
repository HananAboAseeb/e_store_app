import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_history_entity.dart';
import '../repositories/settings_repository.dart';

class GetPaymentHistoryUseCase
    implements UseCase<List<PaymentHistoryEntity>, NoParam> {
  final SettingsRepository repository;

  GetPaymentHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentHistoryEntity>>> call([NoParam? param]) =>
      repository.getPaymentHistory();
}
