import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/country_entity.dart';
import '../entities/currency_entity.dart';
import '../entities/language_entity.dart';
import '../entities/payment_card_entity.dart';
import '../entities/payment_history_entity.dart';
import '../entities/shipping_address_entity.dart';
import '../entities/size_standard_entity.dart';
import '../entities/user_account_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserAccountEntity>> getProfile();

  Future<Either<Failure, UserAccountEntity>> updateProfile(
    UserAccountEntity profile,
  );

  Future<Either<Failure, List<PaymentCardEntity>>> getPaymentCards();

  Future<Either<Failure, PaymentCardEntity>> addPaymentCard(
    PaymentCardEntity card,
  );

  Future<Either<Failure, PaymentCardEntity>> updatePaymentCard(
    PaymentCardEntity card,
  );

  Future<Either<Failure, List<PaymentHistoryEntity>>> getPaymentHistory();

  Future<Either<Failure, ShippingAddressEntity>> getShippingAddress();

  Future<Either<Failure, ShippingAddressEntity>> updateShippingAddress(
    ShippingAddressEntity address,
  );

  Future<Either<Failure, List<CountryEntity>>> getCountries();

  Future<Either<Failure, List<LanguageEntity>>> getLanguages();

  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();

  Future<Either<Failure, List<SizeStandardEntity>>> getSizes();

  Future<Either<Failure, void>> updatePreference(String type, String value);

  Future<Either<Failure, void>> deleteAccount();
}
