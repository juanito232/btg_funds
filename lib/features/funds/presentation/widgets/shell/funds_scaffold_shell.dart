import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_actions_provider.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/dialogs/fund_action_feedback_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FundsScaffoldShell extends ConsumerStatefulWidget {
  const FundsScaffoldShell({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<FundsScaffoldShell> createState() => _FundsScaffoldShellState();
}

class _FundsScaffoldShellState extends ConsumerState<FundsScaffoldShell> {
  @override
  Widget build(BuildContext context) {
    final actionsState = ref.watch(fundActionsProvider);

    ref.listen<FundActionsState>(fundActionsProvider, (previous, next) {
      if (next.isLoading) return;

      final message = next.error ?? next.successMessage;
      if (message == null || message.isEmpty) return;

      if (previous != null &&
          !previous.isLoading &&
          (previous.error ?? previous.successMessage) == message) {
        return;
      }

      final isError = next.error != null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showFundActionFeedbackDialog(
          context,
          message: message,
          isError: isError,
        ).then((_) {
          ref.read(fundActionsProvider.notifier).clearMessages();
        });
      });
    });

    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'BTG Fondos',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.savings_outlined),
                title: const Text('Fondos'),
                selected: location == AppRoutes.home,
                onTap: () {
                  context.go(AppRoutes.home);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.pie_chart_outline_rounded),
                title: const Text('Mis participaciones'),
                selected: location == AppRoutes.participaciones,
                onTap: () {
                  context.go(AppRoutes.participaciones);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('Historial'),
                selected: location == AppRoutes.historial,
                onTap: () {
                  context.go(AppRoutes.historial);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (actionsState.isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.35),
                  child: Center(
                    child: Semantics(
                      label: 'Procesando operación, por favor espere',
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Procesando…',
                                style:
                                    Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
