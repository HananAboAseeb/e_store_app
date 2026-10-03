import '../../core/di/injection_container.dart';
import 'data/datasources/orders_mock_datasource.dart';
import 'data/datasources/orders_mock_datasource_impl.dart';
import 'data/repositories/orders_repository_impl.dart';
import 'domain/repositories/orders_repository.dart';
import 'domain/usecases/get_items_to_review_usecase.dart';
import 'domain/usecases/get_order_history_usecase.dart';
import 'domain/usecases/get_order_tracking_usecase.dart';
import 'domain/usecases/get_orders_usecase.dart';
import 'domain/usecases/submit_review_usecase.dart';
import 'presentation/cubit/order_review_cubit.dart';
import 'presentation/cubit/order_tracking_cubit.dart';
import 'presentation/cubit/orders_cubit.dart';

void initOrdersInjection() {
  // Data Source
  sl.registerLazySingleton<OrdersMockDataSource>(
    () => OrdersMockDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(mockDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderHistoryUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderTrackingUseCase(sl()));
  sl.registerLazySingleton(() => GetItemsToReviewUseCase(sl()));
  sl.registerLazySingleton(() => SubmitReviewUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => OrdersCubit(
      getOrdersUseCase: sl(),
      getOrderHistoryUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => OrderTrackingCubit(
      getOrderTrackingUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => OrderReviewCubit(
      getItemsToReviewUseCase: sl(),
      submitReviewUseCase: sl(),
    ),
  );
}
