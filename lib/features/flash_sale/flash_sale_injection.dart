import '../../core/di/injection_container.dart';
import 'data/datasources/flash_sale_mock_datasource.dart';
import 'data/datasources/flash_sale_mock_datasource_impl.dart';
import 'data/repositories/flash_sale_repository_impl.dart';
import 'domain/repositories/flash_sale_repository.dart';
import 'domain/usecases/get_flash_sale_data_usecase.dart';
import 'presentation/cubit/flash_sale_cubit.dart';

void initFlashSale() {
  // Cubit
  sl.registerFactory<FlashSaleCubit>(
    () => FlashSaleCubit(getFlashSaleDataUseCase: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<GetFlashSaleDataUseCase>(
    () => GetFlashSaleDataUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<FlashSaleRepository>(
    () => FlashSaleRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<FlashSaleMockDataSource>(
    () => FlashSaleMockDataSourceImpl(),
  );
}
