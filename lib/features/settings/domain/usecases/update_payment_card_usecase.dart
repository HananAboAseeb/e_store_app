import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_card_entity.dart';
import '../repositories/settings_repository.dart';

class UpdatePaymentCardUseCase
    implements UseCase<PaymentCardEntity, PaymentCardEntity> {
  final SettingsRepository repository;

  UpdatePaymentCardUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentCardEntity>> call([PaymentCardEntity? param]) =>
      repository.updatePaymentCard(param!);
}
