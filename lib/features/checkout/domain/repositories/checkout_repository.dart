import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/checkout_summary_entity.dart';
import '../entities/shipping_address_entity.dart';
import '../entities/voucher_entity.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, CheckoutSummaryEntity>> getCheckoutSummary();

  Future<Either<Failure, List<VoucherEntity>>> getActiveVouchers();

  Future<Either<Failure, CheckoutSummaryEntity>> applyVoucher(String voucherId);

  Future<Either<Failure, CheckoutSummaryEntity>> removeVoucher();

  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingOption(
      String optionId);

  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingAddress(
      ShippingAddressEntity address);

  Future<Either<Failure, CheckoutSummaryEntity>> updatePaymentMethod(
      String method);
}
