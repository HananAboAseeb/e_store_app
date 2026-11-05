import 'package:get_it/get_it.dart';

import 'data/datasources/settings_mock_data_source.dart';
import 'data/datasources/settings_mock_data_source_impl.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/repositories/settings_repository.dart';
import 'domain/usecases/add_payment_card_usecase.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'domain/usecases/get_payment_cards_usecase.dart';
import 'domain/usecases/get_payment_history_usecase.dart';
import 'domain/usecases/get_preferences_usecase.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/get_shipping_address_usecase.dart';
import 'domain/usecases/update_payment_card_usecase.dart';
import 'domain/usecases/update_preference_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/update_shipping_address_usecase.dart';
import 'presentation/cubits/account_cubit.dart';
import 'presentation/cubits/payment_settings_cubit.dart';
import 'presentation/cubits/preferences_cubit.dart';
import 'presentation/cubits/settings_cubit.dart';
import 'presentation/cubits/shipping_settings_cubit.dart';

void initSettingsInjection() {
  final sl = GetIt.instance;

  // ── Datasources ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<SettingsMockDataSource>(
    () => SettingsMockDataSourceImpl(),
  );

  // ── Repository ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsMockDataSource>()),
  );

  // ── UseCases ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetProfileUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => UpdateProfileUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => GetPaymentCardsUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => AddPaymentCardUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => UpdatePaymentCardUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => GetPaymentHistoryUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => GetShippingAddressUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => UpdateShippingAddressUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => GetPreferencesUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => UpdatePreferenceUseCase(sl<SettingsRepository>()));
  sl.registerLazySingleton(
      () => DeleteAccountUseCase(sl<SettingsRepository>()));

  // ── Cubits (Factory) ────────────────────────────────────────────────────────
  sl.registerFactory(() => SettingsCubit(
        deleteAccountUseCase: sl<DeleteAccountUseCase>(),
      ));

  sl.registerFactory(() => AccountCubit(
        getProfileUseCase: sl<GetProfileUseCase>(),
        updateProfileUseCase: sl<UpdateProfileUseCase>(),
      ));

  sl.registerFactory(() => PaymentSettingsCubit(
        getPaymentCardsUseCase: sl<GetPaymentCardsUseCase>(),
        addPaymentCardUseCase: sl<AddPaymentCardUseCase>(),
        updatePaymentCardUseCase: sl<UpdatePaymentCardUseCase>(),
        getPaymentHistoryUseCase: sl<GetPaymentHistoryUseCase>(),
      ));

  sl.registerFactory(() => ShippingSettingsCubit(
        getShippingAddressUseCase: sl<GetShippingAddressUseCase>(),
        updateShippingAddressUseCase: sl<UpdateShippingAddressUseCase>(),
      ));

  sl.registerLazySingleton(() => PreferencesCubit(
        getPreferencesUseCase: sl<GetPreferencesUseCase>(),
        updatePreferenceUseCase: sl<UpdatePreferenceUseCase>(),
      ));
}
