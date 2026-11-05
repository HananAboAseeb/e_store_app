import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_card_entity.dart';
import '../repositories/settings_repository.dart';

class GetPaymentCardsUseCase
    implements UseCase<List<PaymentCardEntity>, NoParam> {
  final SettingsRepository repository;

  GetPaymentCardsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentCardEntity>>> call([NoParam? param]) =>
      repository.getPaymentCards();
}
