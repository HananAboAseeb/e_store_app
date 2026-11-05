import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/shipping_address_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateShippingAddressUseCase
    implements UseCase<ShippingAddressEntity, ShippingAddressEntity> {
  final SettingsRepository repository;

  UpdateShippingAddressUseCase(this.repository);

  @override
  Future<Either<Failure, ShippingAddressEntity>> call([
    ShippingAddressEntity? param,
  ]) =>
      repository.updateShippingAddress(param!);
}
