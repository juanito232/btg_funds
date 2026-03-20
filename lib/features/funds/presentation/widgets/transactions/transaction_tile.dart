import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSubscription = transaction.type == TransactionType.subscription;
    final label = isSubscription ? 'Suscripción' : 'Cancelación';
    final amountPrefix = isSubscription ? '+' : '−';

    final accent = isSubscription ? scheme.tertiary : scheme.secondary;

    return Semantics(
      label:
          '$label en ${transaction.fundName}, monto $amountPrefix ${formatCop(transaction.amount, decimals: true)}',
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: accent.withValues(alpha: 0.2),
            child: Icon(
              isSubscription ? Icons.add_rounded : Icons.remove_rounded,
              color: accent,
              size: 22,
            ),
          ),
          title: Text(
            transaction.fundName,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '$label · ${_formatDate(transaction.date)} · Notif.: ${transaction.notificationMethod.label}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          trailing: Text(
            '$amountPrefix${formatCop(transaction.amount, decimals: true)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
