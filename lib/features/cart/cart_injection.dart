import '../../core/di/injection_container.dart';
import 'data/datasources/cart_mock_data_source.dart';
import 'data/datasources/cart_mock_data_source_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/add_to_cart_usecase.dart';
import 'domain/usecases/clear_cart_usecase.dart';
import 'domain/usecases/get_cart_usecase.dart';
import 'domain/usecases/remove_from_cart_usecase.dart';
import 'domain/usecases/remove_wishlist_suggestion_usecase.dart';
import 'domain/usecases/update_cart_quantity_usecase.dart';
import 'presentation/manager/cart_cubit.dart';

void initCart() {
  // Data Sources
  sl.registerLazySingleton<CartMockDataSource>(
    () => CartMockDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => RemoveWishlistSuggestionUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));

  // State Management (Cubit)
  sl.registerFactory(
    () => CartCubit(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      updateCartQuantityUseCase: sl(),
      removeWishlistSuggestionUseCase: sl(),
      clearCartUseCase: sl(),
    ),
  );
}
