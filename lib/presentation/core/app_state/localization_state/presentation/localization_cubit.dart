import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final GetSavedLanguage getSavedLanguage;
  final SaveLanguage saveLanguage;

  LocalizationCubit({
    required this.getSavedLanguage,
    required this.saveLanguage,
  }) : super(LocalizationState(languageCode: 'en'));

  Future<void> loadSavedLanguage() async {
    final language = await getSavedLanguage();
    emit(LocalizationState(languageCode: language));
  }

  Future<void> changeLanguage({required String languageCode}) async {
    await saveLanguage(languageCode: languageCode);
    emit(LocalizationState(languageCode: languageCode));
  }
}
