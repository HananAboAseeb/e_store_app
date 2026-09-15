import '../../core/di/injection_container.dart';
import 'data/datasources/shop_mock_datasource.dart';
import 'data/datasources/shop_mock_datasource_impl.dart';
import 'data/repositories/shop_repository_impl.dart';
import 'domain/repositories/shop_repository.dart';
import 'domain/usecases/get_shop_categories_usecase.dart';
import 'domain/usecases/get_shop_products_usecase.dart';
import 'presentation/cubit/filter_cubit.dart';
import 'presentation/cubit/shop_cubit.dart';

void initShop() {
  // Cubits
  sl.registerFactory<ShopCubit>(
    () => ShopCubit(
      getShopProductsUseCase: sl(),
      getShopCategoriesUseCase: sl(),
    ),
  );

  sl.registerFactory<FilterCubit>(
    () => FilterCubit(),
  );

  // Use Cases
  sl.registerLazySingleton<GetShopProductsUseCase>(
    () => GetShopProductsUseCase(sl()),
  );

  sl.registerLazySingleton<GetShopCategoriesUseCase>(
    () => GetShopCategoriesUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ShopMockDataSource>(
    () => ShopMockDataSourceImpl(),
  );
}
