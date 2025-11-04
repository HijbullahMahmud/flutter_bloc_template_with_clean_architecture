import 'package:flutter_bloc_theme_management/presentation/core/app_state/theme_state/domain/entities/app_theme.dart';
import 'package:flutter_bloc_theme_management/presentation/core/app_state/theme_state/domain/repository/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository repository;

  GetThemeUseCase({required this.repository});

  Future<AppTheme> call() => repository.getTheme();
}

class SetThemeUseCase {
  final ThemeRepository repository;

  SetThemeUseCase({required this.repository});

  Future<void> call(AppTheme theme) => repository.setTheme(theme);
}
