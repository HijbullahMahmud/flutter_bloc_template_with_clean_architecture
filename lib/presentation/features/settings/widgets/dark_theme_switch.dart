import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/presentation/core/app_state/theme_state/theme_state.dart';

class DarkThemeSwitch extends StatelessWidget {
  const DarkThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.appTheme != current.appTheme,
      builder: (context, state) {
        final brightnss = MediaQuery.of(context).platformBrightness;
        final isDark = state.appTheme == AppTheme.system
            ? brightnss == Brightness.dark
            : state.appTheme == AppTheme.dark;

        return SwitchListTile.adaptive(
          title: Text("Dark Theme"),
          value: isDark,
          onChanged: (value) {
            final newTheme = value ? AppTheme.dark : AppTheme.light;
            context.read<ThemeCubit>().changeTheme(newTheme);
          },
        );
      },
    );
  }
}
