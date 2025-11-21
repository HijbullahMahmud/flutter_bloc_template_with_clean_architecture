import 'package:flutter/material.dart';
// import 'package:flutter_bloc_template/presentation/core/router/go_router_refresh_stream.dart';
import 'package:flutter_bloc_template/presentation/core/router/routes.dart';
import 'package:flutter_bloc_template/presentation/features/posts/screens/post_screen.dart';
import 'package:flutter_bloc_template/presentation/features/splash/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc_template/presentation/core/widgets/navigation_shell.dart';

import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';

part 'parts/shell_routes.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return null;
    },

    // Listen to auth state changes
    // refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
      ),
      _shellRoute(),
      GoRoute(
        path: Routes.postsScreen,
        name: Routes.postsScreen,
        pageBuilder: (context, state) => MaterialPage(child: PostScreen()),
      ),
    ],

    // Error handling
    // errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );
}
