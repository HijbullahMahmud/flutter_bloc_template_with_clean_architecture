 
import '../../localization_state.dart';

class GetSavedLanguage {
  final LocalizationRepository repository;

  GetSavedLanguage({required this.repository});

  Future<String> call() async {
    return await repository.getSavedLanguage() ?? 'en';
  }
}
