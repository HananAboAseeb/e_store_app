import '../../core/di/injection_container.dart';
import 'data/datasources/home_mock_datasource.dart';
import 'data/datasources/home_mock_datasource_impl.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_home_data_usecase.dart';
import 'presentation/cubit/home_cubit.dart';

void initHome() {
  // Cubit
  sl.registerFactory(() => HomeCubit(getHomeDataUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<HomeMockDataSource>(
    () => HomeMockDataSourceImpl(),
  );
}
