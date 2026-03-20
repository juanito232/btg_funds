import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/funds/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/features/funds/presentation/screens/participations_screen.dart';
import 'package:flutter_application_1/features/funds/presentation/screens/transaction_history_screen.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/shell/funds_scaffold_shell.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const participaciones = '/participaciones';
  static const historial = '/historial';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return FundsScaffoldShell(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.participaciones,
          name: 'participaciones',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const ParticipationsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.historial,
          name: 'historial',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const TransactionHistoryScreen(),
          ),
        ),
      ],
    ),
  ],
);
