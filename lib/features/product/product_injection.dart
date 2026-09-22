import '../../core/di/injection_container.dart';
import 'data/datasources/product_mock_datasource.dart';
import 'data/datasources/product_mock_datasource_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_product_details_usecase.dart';
import 'domain/usecases/get_product_reviews_usecase.dart';
import 'domain/usecases/vote_review_usecase.dart';
import 'presentation/cubit/product_details_cubit.dart';
import 'presentation/cubit/reviews_cubit.dart';

void initProductInjection() {
  // Data Sources
  sl.registerLazySingleton<ProductMockDataSource>(
    () => ProductMockDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(mockDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProductDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductReviewsUseCase(sl()));
  sl.registerLazySingleton(() => VoteReviewUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => ProductDetailsCubit(getProductDetailsUseCase: sl()),
  );
  sl.registerFactory(
    () => ReviewsCubit(
      getProductReviewsUseCase: sl(),
      voteReviewUseCase: sl(),
    ),
  );
}
