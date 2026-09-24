import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/checkout_summary_entity.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/entities/voucher_entity.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_mock_data_source.dart';
import '../models/shipping_address_model.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutMockDataSource mockDataSource;

  CheckoutRepositoryImpl(this.mockDataSource);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> getCheckoutSummary() async {
    return await safeCall(() => mockDataSource.getCheckoutSummary());
  }

  @override
  Future<Either<Failure, List<VoucherEntity>>> getActiveVouchers() async {
    return await safeCall(() => mockDataSource.getActiveVouchers());
  }

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> applyVoucher(
      String voucherId) async {
    return await safeCall(() => mockDataSource.applyVoucher(voucherId));
  }

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> removeVoucher() async {
    return await safeCall(() => mockDataSource.removeVoucher());
  }

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingOption(
      String optionId) async {
    return await safeCall(() => mockDataSource.updateShippingOption(optionId));
  }

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingAddress(
      ShippingAddressEntity address) async {
    final addressModel = ShippingAddressModel.fromEntity(address);
    return await safeCall(
      () => mockDataSource.updateShippingAddress(addressModel),
    );
  }

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> updatePaymentMethod(
      String method) async {
    return await safeCall(() => mockDataSource.updatePaymentMethod(method));
  }
}
