import '../../core/di/injection_container.dart';
import 'data/datasources/categories_mock_datasource.dart';
import 'data/datasources/categories_mock_datasource_impl.dart';
import 'data/repositories/categories_repository_impl.dart';
import 'domain/repositories/categories_repository.dart';
import 'domain/usecases/get_categories_usecase.dart';
import 'domain/usecases/get_just_for_you_products_usecase.dart';
import 'presentation/cubit/categories_cubit.dart';

void initCategories() {
  // Cubits
  sl.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      getCategoriesUseCase: sl(),
      getJustForYouProductsUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton<GetJustForYouProductsUseCase>(
    () => GetJustForYouProductsUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<CategoriesMockDataSource>(
    () => CategoriesMockDataSourceImpl(),
  );
}
