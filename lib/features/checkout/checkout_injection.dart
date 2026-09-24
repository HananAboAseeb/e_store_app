import '../../core/di/injection_container.dart';
import 'data/datasources/checkout_mock_data_source.dart';
import 'data/datasources/checkout_mock_data_source_impl.dart';
import 'data/repositories/checkout_repository_impl.dart';
import 'domain/repositories/checkout_repository.dart';
import 'domain/usecases/apply_voucher_usecase.dart';
import 'domain/usecases/get_active_vouchers_usecase.dart';
import 'domain/usecases/get_checkout_summary_usecase.dart';
import 'domain/usecases/remove_voucher_usecase.dart';
import 'domain/usecases/update_shipping_address_usecase.dart';
import 'domain/usecases/update_shipping_option_usecase.dart';
import 'presentation/manager/checkout_cubit.dart';

void initCheckoutInjection() {
  // Cubit
  sl.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      getCheckoutSummaryUseCase: sl(),
      getActiveVouchersUseCase: sl(),
      applyVoucherUseCase: sl(),
      removeVoucherUseCase: sl(),
      updateShippingOptionUseCase: sl(),
      updateShippingAddressUseCase: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetCheckoutSummaryUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveVouchersUseCase(sl()));
  sl.registerLazySingleton(() => ApplyVoucherUseCase(sl()));
  sl.registerLazySingleton(() => RemoveVoucherUseCase(sl()));
  sl.registerLazySingleton(() => UpdateShippingOptionUseCase(sl()));
  sl.registerLazySingleton(() => UpdateShippingAddressUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(sl()),
  );

  // DataSource
  sl.registerLazySingleton<CheckoutMockDataSource>(
    () => CheckoutMockDataSourceImpl(),
  );
}
