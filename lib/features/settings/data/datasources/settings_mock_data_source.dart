import '../models/country_model.dart';
import '../models/currency_model.dart';
import '../models/language_model.dart';
import '../models/payment_card_model.dart';
import '../models/payment_history_model.dart';
import '../models/shipping_address_model.dart';
import '../models/size_standard_model.dart';
import '../models/user_account_model.dart';

abstract class SettingsMockDataSource {
  Future<UserAccountModel> getProfile();

  Future<UserAccountModel> updateProfile(UserAccountModel profile);

  Future<List<PaymentCardModel>> getPaymentCards();

  Future<PaymentCardModel> addPaymentCard(PaymentCardModel card);

  Future<PaymentCardModel> updatePaymentCard(PaymentCardModel card);

  Future<List<PaymentHistoryModel>> getPaymentHistory();

  Future<ShippingAddressModel> getShippingAddress();

  Future<ShippingAddressModel> updateShippingAddress(
    ShippingAddressModel address,
  );

  Future<List<CountryModel>> getCountries();

  Future<List<LanguageModel>> getLanguages();

  Future<List<CurrencyModel>> getCurrencies();

  Future<List<SizeStandardModel>> getSizes();

  Future<void> updatePreference(String type, String value);

  Future<void> deleteAccount();
}
