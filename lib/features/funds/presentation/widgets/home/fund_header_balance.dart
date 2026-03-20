import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Saldo compacto para la cabecera (fondo primary / texto claro).
class FundHeaderBalance extends ConsumerWidget {
  const FundHeaderBalance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);

    return balanceAsync.when(
      data: (balance) => Semantics(
        label: 'Saldo disponible ${formatCop(balance, decimals: true)}',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Saldo disponible',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.88),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formatCop(balance, decimals: true),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
      loading: () => SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
      error: (_, _) => Icon(
        Icons.error_outline_rounded,
        color: Colors.white.withValues(alpha: 0.9),
        size: 26,
      ),
    );
  }
}
