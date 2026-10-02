import '../../core/di/injection_container.dart';
import '../cart/domain/repositories/cart_repository.dart';
import 'data/datasources/wishlist_mock_datasource.dart';
import 'data/datasources/wishlist_mock_datasource_impl.dart';
import 'data/repositories/wishlist_repository_impl.dart';
import 'domain/repositories/wishlist_repository.dart';
import 'domain/usecases/add_to_cart_from_wishlist_usecase.dart';
import 'domain/usecases/get_recently_viewed_usecase.dart';
import 'domain/usecases/get_wishlist_popular_products_usecase.dart';
import 'domain/usecases/get_wishlist_usecase.dart';
import 'domain/usecases/remove_from_wishlist_usecase.dart';
import 'presentation/cubit/recently_viewed_cubit.dart';
import 'presentation/cubit/wishlist_cubit.dart';

void initWishlist() {
  // Data Source
  sl.registerLazySingleton<WishlistMockDataSource>(
    () => WishlistMockDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      mockDataSource: sl(),
      cartRepository:
          sl.isRegistered<CartRepository>() ? sl<CartRepository>() : null,
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartFromWishlistUseCase(sl()));
  sl.registerLazySingleton(() => GetRecentlyViewedUseCase(sl()));
  sl.registerLazySingleton(() => GetWishlistPopularProductsUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => WishlistCubit(
      getWishlistUseCase: sl(),
      removeFromWishlistUseCase: sl(),
      addToCartFromWishlistUseCase: sl(),
      getWishlistPopularProductsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => RecentlyViewedCubit(
      getRecentlyViewedUseCase: sl(),
    ),
  );
}
