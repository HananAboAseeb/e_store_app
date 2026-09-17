import '../../core/di/injection_container.dart';
import 'data/datasources/search_mock_datasource.dart';
import 'data/datasources/search_mock_datasource_impl.dart';
import 'data/repositories/search_repository_impl.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/usecases/clear_search_history_usecase.dart';
import 'domain/usecases/get_search_data_usecase.dart';
import 'domain/usecases/search_by_image_usecase.dart';
import 'domain/usecases/search_by_text_usecase.dart';
import 'presentation/cubit/image_search_cubit.dart';
import 'presentation/cubit/search_cubit.dart';

void initSearch() {
  // Cubits
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(
      getSearchDataUseCase: sl(),
      searchByTextUseCase: sl(),
      clearSearchHistoryUseCase: sl(),
    ),
  );

  sl.registerFactory<ImageSearchCubit>(
    () => ImageSearchCubit(
      searchByImageUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetSearchDataUseCase>(
    () => GetSearchDataUseCase(sl()),
  );
  sl.registerLazySingleton<SearchByTextUseCase>(
    () => SearchByTextUseCase(sl()),
  );
  sl.registerLazySingleton<SearchByImageUseCase>(
    () => SearchByImageUseCase(sl()),
  );
  sl.registerLazySingleton<ClearSearchHistoryUseCase>(
    () => ClearSearchHistoryUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<SearchMockDataSource>(
    () => SearchMockDataSourceImpl(),
  );
}
