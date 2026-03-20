import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/transactions/transaction_tile.dart';

class TransactionListPanel extends StatelessWidget {
  const TransactionListPanel({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(FundLayout.tileRadius),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 420),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          shrinkWrap: true,
          itemCount: transactions.length,
          separatorBuilder: (_, _) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            return TransactionTile(transaction: transactions[index]);
          },
        ),
      ),
    );
  }
}
