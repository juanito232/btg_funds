import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_empty_state.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_error_display.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_loading_placeholder.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_section_title.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/transactions/transaction_list_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistorySection extends ConsumerWidget {
  const TransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FundSectionTitle(
          icon: Icons.history_rounded,
          title: 'Historial de transacciones',
          subtitle: 'Suscripciones y cancelaciones recientes en orden cronológico.',
        ),
        const SizedBox(height: FundLayout.blockGap),
        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return const FundEmptyState(
                message: 'Cuando realices movimientos, aparecerán aquí.',
                icon: Icons.receipt_long_outlined,
              );
            }
            return TransactionListPanel(transactions: transactions);
          },
          loading: () => const FundLoadingPlaceholder(height: 200),
          error: (e, _) => FundErrorDisplay(message: e.toString()),
        ),
      ],
    );
  }
}
