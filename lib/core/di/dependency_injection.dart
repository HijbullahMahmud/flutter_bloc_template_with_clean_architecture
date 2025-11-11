import 'package:flutter_bloc_template/data/post/datasources/local/post_local_datasource.dart';
import 'package:flutter_bloc_template/data/post/datasources/remote/post_remote_datasource.dart';
import 'package:flutter_bloc_template/data/post/repositories/post_repository_impl.dart';
import 'package:flutter_bloc_template/data/service/local/cache_service.dart';
import 'package:flutter_bloc_template/data/service/local/local_db.dart';
import 'package:flutter_bloc_template/data/service/local/local_db_impl.dart';
import 'package:flutter_bloc_template/data/service/local/shared_preference_service.dart';
import 'package:flutter_bloc_template/data/service/remote/dio_network_service_impl.dart';
import 'package:flutter_bloc_template/data/service/remote/network_service.dart';
import 'package:flutter_bloc_template/data/service/remote/token_manager.dart';
import 'package:flutter_bloc_template/domain/post/repositories/post_repository.dart';
import 'package:flutter_bloc_template/domain/post/usecases/get_posts_usecase.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/data/datasource/theme_local_datasource.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/data/repository/theme_repository_impl.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/domain/repository/theme_repository.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/domain/use_cases/theme_use_case.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/presentation/bloc/theme_cubit.dart';
import 'package:flutter_bloc_template/presentation/core/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/core/app_state/localization_state/localization_state.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  // Singleton database instance
  final localDb = LocalDbImpl();
  await localDb.initialize();
  injector.registerSingleton<LocalDb>(localDb);

  // Shared Preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  injector.registerLazySingleton<CacheService>(
    () => SharedPreferenceService(prefs: sharedPrefs),
  );

  //Remote
  injector.registerLazySingleton<TokenManager>(
    () => TokenManager(injector.get<CacheService>()),
  );
  injector.registerLazySingleton<NetworkService>(
    () => DioNetworkServiceImpl(tokenManager: injector.get<TokenManager>()),
  );

  // Router
  injector.registerLazySingleton<AppRouter>(() => AppRouter());
}

//-------Datasources-------//
void initDataSource() {
  injector.registerFactory<ThemeLocalDatasource>(
    () => ThemeLocalDatasourceImpl(cacheService: injector.get<CacheService>()),
  );

  injector.registerFactory<LocalizationDatasource>(
    () =>
        LocalizationDatasourceImpl(cacheService: injector.get<CacheService>()),
  );

  // Posts
  injector.registerFactory<PostLocalDatasource>(
    () => PostLocalDatasourceImpl(localDb: injector.get<LocalDb>()),
  );
  injector.registerFactory<PostRemoteDatasource>(
    () => PostRemoteDatasourceImpl(
      networkService: injector.get<NetworkService>(),
    ),
  );
}

//-------Repositories-------//
void initRepositories() {
  injector.registerFactory<ThemeRepository>(
    () => ThemeRepositoryImpl(datasource: injector.get<ThemeLocalDatasource>()),
  );

  injector.registerFactory<LocalizationRepository>(
    () => LocalizationRepositoryImpl(
      datasource: injector.get<LocalizationDatasource>(),
    ),
  );

  // Posts
  injector.registerFactory<PostRepository>(
    () => PostRepositoryImpl(
      remoteDatasource: injector.get<PostRemoteDatasource>(),
      localDatasource: injector.get<PostLocalDatasource>(),
    ),
  );
}

//-------UseCases-------//
void initUseCases() {
  injector.registerFactory<GetThemeUseCase>(
    () => GetThemeUseCase(repository: injector.get<ThemeRepository>()),
  );
  injector.registerFactory<SetThemeUseCase>(
    () => SetThemeUseCase(repository: injector.get<ThemeRepository>()),
  );

  //localization
  injector.registerFactory<GetSavedLanguage>(
    () => GetSavedLanguage(repository: injector.get<LocalizationRepository>()),
  );

  injector.registerFactory<SaveLanguage>(
    () => SaveLanguage(repository: injector.get<LocalizationRepository>()),
  );

  // Post
  injector.registerFactory<GetPostsUsecase>(
    () => GetPostsUsecase(repository: injector.get<PostRepository>()),
  );
}

//-------BloCs-------//
void initBlocs() {
  injector.registerFactory<ThemeCubit>(
    () => ThemeCubit(
      getThemeUseCase: injector.get<GetThemeUseCase>(),
      setThemeUseCase: injector.get<SetThemeUseCase>(),
    ),
  );

  injector.registerFactory<LocalizationCubit>(
    () => LocalizationCubit(
      getSavedLanguage: injector.get<GetSavedLanguage>(),
      saveLanguage: injector.get<SaveLanguage>(),
    ),
  );
}
