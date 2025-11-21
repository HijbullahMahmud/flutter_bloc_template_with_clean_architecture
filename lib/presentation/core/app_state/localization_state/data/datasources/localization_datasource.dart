import 'package:flutter_bloc_template/data/service/local/cache_service.dart';

abstract class LocalizationDatasource {
  Future<String?> getSavedLanguage();
  Future<void> saveLanguage(String languageCode);
}

class LocalizationDatasourceImpl extends LocalizationDatasource {
  final CacheService cacheService;

  LocalizationDatasourceImpl({required this.cacheService});

  @override
  Future<String?> getSavedLanguage() async {
    return cacheService.get<String>(CacheKey.savedLanguage);
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await cacheService.save<String>(CacheKey.savedLanguage, languageCode);
  }
}
