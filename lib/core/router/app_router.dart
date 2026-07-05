import 'package:go_router/go_router.dart';
import '../../features/finance_tracker/domain/entities/week_entry.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/finance_tracker/presentation/screens/add_entry_screen.dart';
import '../../features/finance_tracker/presentation/screens/categories_screen.dart';
import '../../features/finance_tracker/presentation/screens/dashboard_screen.dart';
import '../../features/finance_tracker/presentation/screens/history_screen.dart';
import '../../features/finance_tracker/presentation/screens/settings_screen.dart';
import '../presentation/screens/main_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/dashboard', builder: (_, __) => const DashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/add_entry',
            builder: (context, state) =>
                AddEntryScreen(initialEntry: state.extra as WeekEntry?),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/categories',
            builder: (_, __) => const CategoriesScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/history', builder: (_, __) => const HistoryScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/settings', builder: (_, __) => const SettingsScreen()),
        ]),
      ],
    ),
  ],
);
