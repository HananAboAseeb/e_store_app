import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/entities/payment_card_entity.dart';
import '../../domain/entities/payment_history_entity.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/entities/size_standard_entity.dart';
import '../../domain/entities/user_account_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_mock_data_source.dart';
import '../models/payment_card_model.dart';
import '../models/shipping_address_model.dart';
import '../models/user_account_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsMockDataSource mockDataSource;

  SettingsRepositoryImpl(this.mockDataSource);

  @override
  Future<Either<Failure, UserAccountEntity>> getProfile() async {
    return await safeCall(() async {
      return await mockDataSource.getProfile();
    });
  }

  @override
  Future<Either<Failure, UserAccountEntity>> updateProfile(
    UserAccountEntity profile,
  ) async {
    return await safeCall(() async {
      final model = UserAccountModel.fromEntity(profile);
      return await mockDataSource.updateProfile(model);
    });
  }

  @override
  Future<Either<Failure, List<PaymentCardEntity>>> getPaymentCards() async {
    return await safeCall(() async {
      final models = await mockDataSource.getPaymentCards();
      return List<PaymentCardEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, PaymentCardEntity>> addPaymentCard(
    PaymentCardEntity card,
  ) async {
    return await safeCall(() async {
      final model = PaymentCardModel.fromEntity(card);
      return await mockDataSource.addPaymentCard(model);
    });
  }

  @override
  Future<Either<Failure, PaymentCardEntity>> updatePaymentCard(
    PaymentCardEntity card,
  ) async {
    return await safeCall(() async {
      final model = PaymentCardModel.fromEntity(card);
      return await mockDataSource.updatePaymentCard(model);
    });
  }

  @override
  Future<Either<Failure, List<PaymentHistoryEntity>>>
      getPaymentHistory() async {
    return await safeCall(() async {
      final models = await mockDataSource.getPaymentHistory();
      return List<PaymentHistoryEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, ShippingAddressEntity>> getShippingAddress() async {
    return await safeCall(() async {
      return await mockDataSource.getShippingAddress();
    });
  }

  @override
  Future<Either<Failure, ShippingAddressEntity>> updateShippingAddress(
    ShippingAddressEntity address,
  ) async {
    return await safeCall(() async {
      final model = ShippingAddressModel.fromEntity(address);
      return await mockDataSource.updateShippingAddress(model);
    });
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    return await safeCall(() async {
      final models = await mockDataSource.getCountries();
      return List<CountryEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, List<LanguageEntity>>> getLanguages() async {
    return await safeCall(() async {
      final models = await mockDataSource.getLanguages();
      return List<LanguageEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() async {
    return await safeCall(() async {
      final models = await mockDataSource.getCurrencies();
      return List<CurrencyEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, List<SizeStandardEntity>>> getSizes() async {
    return await safeCall(() async {
      final models = await mockDataSource.getSizes();
      return List<SizeStandardEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, void>> updatePreference(
    String type,
    String value,
  ) async {
    return await safeCall(() async {
      await mockDataSource.updatePreference(type, value);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    return await safeCall(() async {
      await mockDataSource.deleteAccount();
    });
  }
}
