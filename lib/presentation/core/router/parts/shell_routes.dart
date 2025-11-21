

part of '../app_router.dart';

StatefulShellRoute _shellRoute() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        NavigationShell(statefulNavigationShell: navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.home,
            name: Routes.home,
            pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            pageBuilder: (context, state) =>
                MaterialPage(child: ProfileScreen()),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.setting,
            name: Routes.setting,
            pageBuilder: (context, state) =>
                MaterialPage(child: SettingsScreen()),
          ),
        ],
      ),
    ],
  );
}
