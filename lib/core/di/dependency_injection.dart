import 'package:flutter_bloc_theme_management/data/service/cache/cache_service.dart';
import 'package:flutter_bloc_theme_management/data/service/cache/shared_preference_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  injector.registerLazySingleton<CacheService>(
    () => SharedPreferenceService(prefs: sharedPrefs),
  );
  
}
