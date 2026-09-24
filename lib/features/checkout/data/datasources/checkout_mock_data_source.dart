import '../models/checkout_summary_model.dart';
import '../models/shipping_address_model.dart';
import '../models/voucher_model.dart';

abstract class CheckoutMockDataSource {
  Future<CheckoutSummaryModel> getCheckoutSummary();

  Future<List<VoucherModel>> getActiveVouchers();

  Future<CheckoutSummaryModel> applyVoucher(String voucherId);

  Future<CheckoutSummaryModel> removeVoucher();

  Future<CheckoutSummaryModel> updateShippingOption(String optionId);

  Future<CheckoutSummaryModel> updateShippingAddress(
      ShippingAddressModel address);

  Future<CheckoutSummaryModel> updatePaymentMethod(String method);
}
