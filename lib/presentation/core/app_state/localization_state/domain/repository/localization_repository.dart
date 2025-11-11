abstract class LocalizationRepository {
  Future<String?> getSavedLanguage();
  Future<void> saveLanguage(String languageCode);
}
