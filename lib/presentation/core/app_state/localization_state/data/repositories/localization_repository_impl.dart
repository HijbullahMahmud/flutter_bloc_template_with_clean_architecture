import '../../localization_state.dart';

class LocalizationRepositoryImpl extends LocalizationRepository {
  final LocalizationDatasource datasource;
  LocalizationRepositoryImpl({required this.datasource});

  @override
  Future<String?> getSavedLanguage() => datasource.getSavedLanguage();

  @override
  Future<void> saveLanguage(String languageCode) =>
      datasource.saveLanguage(languageCode);
}
