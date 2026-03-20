import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/enums/fund_type.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';

class FundCard extends StatelessWidget {
  const FundCard({super.key, required this.fund, required this.onSubscribe});

  final Fund fund;
  final VoidCallback onSubscribe;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isFpv = fund.type == FundType.fpv;
    final chipBg = isFpv
        ? scheme.primaryContainer.withValues(alpha: 0.55)
        : scheme.tertiaryContainer.withValues(alpha: 0.55);
    final chipFg = isFpv
        ? scheme.onPrimaryContainer
        : scheme.onTertiaryContainer;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isFpv ? 'FPV' : 'FIC',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: chipFg,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    fund.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Divider(),
            Column(
              children: [
                Text(
                  'Mínimo',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  formatCop(fund.minimumAmount),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
            FilledButton.icon(
              onPressed: onSubscribe,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: const Text('Suscribir'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(FundLayout.tileRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
