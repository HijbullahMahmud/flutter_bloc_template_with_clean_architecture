class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  static final Language english = Language(code: 'en', name: 'English');
  static final Language arabic = Language(code: 'ar', name: 'العربية');
  static final Language bengali = Language(code: 'bn', name: 'বাংলা');

  static List<Language> supportedLanguages = [english, arabic, bengali];
}
