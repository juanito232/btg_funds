import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_error_display.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_loading_placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);

    return balanceAsync.when(
      data: (balance) => _BalanceContent(balance: balance),
      loading: () => const FundLoadingPlaceholder(height: 132),
      error: (e, _) => FundErrorDisplay(message: e.toString()),
    );
  }
}

class _BalanceContent extends StatelessWidget {
  const _BalanceContent({required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Saldo disponible ${formatCop(balance, decimals: true)}',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(FundLayout.cardRadius),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.28),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_rounded,
                    color: Colors.white.withValues(alpha: 0.92),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Saldo disponible',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                formatCop(balance, decimals: true),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
