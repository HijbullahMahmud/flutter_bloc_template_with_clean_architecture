import '../../localization_state.dart';

class SaveLanguage {
  final LocalizationRepository repository;

  SaveLanguage({required this.repository});

  Future<void> call({required String languageCode}) =>
      repository.saveLanguage(languageCode);
}
