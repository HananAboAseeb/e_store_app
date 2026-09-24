import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/checkout_summary_entity.dart';
import '../entities/shipping_address_entity.dart';
import '../repositories/checkout_repository.dart';

class UpdateShippingAddressUseCase
    implements UseCase<CheckoutSummaryEntity, ShippingAddressEntity> {
  final CheckoutRepository repository;

  UpdateShippingAddressUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(
          [ShippingAddressEntity? address]) =>
      repository.updateShippingAddress(address!);
}
