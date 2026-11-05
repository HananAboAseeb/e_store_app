import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/shipping_address_entity.dart';
import '../repositories/settings_repository.dart';

class GetShippingAddressUseCase
    implements UseCase<ShippingAddressEntity, NoParam> {
  final SettingsRepository repository;

  GetShippingAddressUseCase(this.repository);

  @override
  Future<Either<Failure, ShippingAddressEntity>> call([NoParam? param]) =>
      repository.getShippingAddress();
}
