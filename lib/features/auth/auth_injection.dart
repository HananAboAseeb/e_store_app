import '../../core/di/injection_container.dart';
import '../../core/network/api_consumer.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_users_usecase.dart';
import 'presentation/manager/user/user_cubit.dart';

void initAuth() {
  // ── State Management ────────────────────────────────────────────────────────
  sl.registerFactory(
    () => UserCubit(sl<GetUsersUseCase>()),
  );

  // ── Use Cases ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(
    () => GetUsersUseCase(sl<AuthRepository>()),
  );

  // ── Repository ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
    ),
  );

  // ── Data Sources ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiConsumer>()),
  );
}
