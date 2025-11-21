import 'package:flutter_bloc_template/data/service/local/cache_service.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/domain/entities/app_theme.dart';

abstract class ThemeLocalDatasource {
  Future<void> cacheTheme(AppTheme theme);
  Future<AppTheme> getCachedTheme();
}

class ThemeLocalDatasourceImpl extends ThemeLocalDatasource {
  final CacheService cacheService;

  ThemeLocalDatasourceImpl({required this.cacheService});

  @override
  Future<void> cacheTheme(AppTheme theme) async {
    await cacheService.save<String>(CacheKey.theme, theme.name);
  }

  @override
  Future<AppTheme> getCachedTheme() async {
    final saved = cacheService.get<String>(CacheKey.theme);
    if (saved == null) return AppTheme.system;
    return AppTheme.values.firstWhere(
      (t) => t.name == saved,
      orElse: () => AppTheme.system,
    );
  }
}
