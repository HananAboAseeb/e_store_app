import '../../core/di/injection_container.dart';
import 'data/datasources/payment_mock_data_source.dart';
import 'data/datasources/payment_mock_data_source_impl.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'domain/repositories/payment_repository.dart';
import 'domain/usecases/add_payment_method_usecase.dart';
import 'domain/usecases/get_payment_methods_usecase.dart';
import 'domain/usecases/process_payment_usecase.dart';
import 'presentation/manager/payment_cubit.dart';

void initPaymentInjection() {
  // Cubit
  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      getPaymentMethodsUseCase: sl(),
      processPaymentUseCase: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetPaymentMethodsUseCase(sl()));
  sl.registerLazySingleton(() => ProcessPaymentUseCase(sl()));
  sl.registerLazySingleton(() => AddPaymentMethodUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl()),
  );

  // DataSource
  sl.registerLazySingleton<PaymentMockDataSource>(
    () => PaymentMockDataSourceImpl(),
  );
}
