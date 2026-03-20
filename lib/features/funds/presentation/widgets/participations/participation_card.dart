import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';

class ParticipationCard extends StatelessWidget {
  const ParticipationCard({
    super.key,
    required this.participation,
    required this.onCancel,
  });

  final Participation participation;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, c) {
            final narrow = c.maxWidth < 420;
            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participation.fundName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Invertido: ${formatCop(participation.investedAmount, decimals: true)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Valor actual: ${formatCop(participation.currentValue, decimals: true)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );

            final button = FilledButton.tonalIcon(
              onPressed: onCancel,
              icon: const Icon(Icons.remove_circle_outline_rounded, size: 20),
              label: const Text('Cancelar'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(FundLayout.tileRadius),
                ),
                backgroundColor: scheme.error.withValues(alpha: 0.85),
              ),
            );

            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [content, const SizedBox(height: 14), button],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: content),
                const SizedBox(width: 12),
                button,
              ],
            );
          },
        ),
      ),
    );
  }
}
