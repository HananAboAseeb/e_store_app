import '../../core/di/injection_container.dart';
import 'data/datasources/profile_mock_data_source.dart';
import 'data/datasources/profile_mock_data_source_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_activity_summary_usecase.dart';
import 'domain/usecases/get_announcement_usecase.dart';
import 'domain/usecases/get_recently_viewed_usecase.dart';
import 'domain/usecases/get_rewards_usecase.dart';
import 'domain/usecases/get_stories_usecase.dart';
import 'domain/usecases/get_user_profile_usecase.dart';
import 'domain/usecases/get_vouchers_usecase.dart';
import 'presentation/manager/my_activity/my_activity_cubit.dart';
import 'presentation/manager/profile/profile_cubit.dart';
import 'presentation/manager/rewards/rewards_cubit.dart';

void initProfile() {
  // ─────────────────────────────────────────────
  // Data Sources
  // ─────────────────────────────────────────────
  sl.registerLazySingleton<ProfileMockDataSource>(
    () => ProfileMockDataSourceImpl(),
  );

  // ─────────────────────────────────────────────
  // Repository
  // ─────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(mockDataSource: sl()),
  );

  // ─────────────────────────────────────────────
  // Use Cases
  // ─────────────────────────────────────────────
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetAnnouncementUseCase(sl()));
  sl.registerLazySingleton(() => GetRecentlyViewedUseCase(sl()));
  sl.registerLazySingleton(() => GetStoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetActivitySummaryUseCase(sl()));
  sl.registerLazySingleton(() => GetVouchersUseCase(sl()));
  sl.registerLazySingleton(() => GetRewardsUseCase(sl()));

  // ─────────────────────────────────────────────
  // State Management (Cubits)
  // ─────────────────────────────────────────────
  sl.registerFactory(
    () => ProfileCubit(
      getUserProfileUseCase: sl(),
      getAnnouncementUseCase: sl(),
      getRecentlyViewedUseCase: sl(),
      getStoriesUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => MyActivityCubit(
      getActivitySummaryUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => RewardsCubit(
      getVouchersUseCase: sl(),
      getRewardsUseCase: sl(),
    ),
  );
}
