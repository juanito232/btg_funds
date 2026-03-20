import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_actions_provider.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_error_display.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_loading_placeholder.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_section_title.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/dialogs/subscribe_dialog.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/funds/funds_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FundsListSection extends ConsumerWidget {
  const FundsListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundsAsync = ref.watch(fundsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FundSectionTitle(
          icon: Icons.savings_outlined,
          title: 'Fondos disponibles',
          subtitle:
              'Elige un fondo y suscríbete respetando el monto mínimo indicado.',
        ),
        const SizedBox(height: FundLayout.blockGap),
        fundsAsync.when(
          data: (funds) => FundsGrid(
            funds: funds,
            onSubscribe: (fund) => _showSubscribeDialog(context, ref, fund),
          ),
          loading: () => const FundLoadingPlaceholder(height: 200),
          error: (e, _) => FundErrorDisplay(message: e.toString()),
        ),
      ],
    );
  }

  void _showSubscribeDialog(
    BuildContext context,
    WidgetRef ref,
    Fund fund,
  ) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => SubscribeDialog(
        fund: fund,
        onSubscribe: (amount, notificationMethod) {
          ref.read(fundActionsProvider.notifier).subscribe(
                fundId: fund.id,
                fundName: fund.name,
                minimumAmount: fund.minimumAmount,
                amount: amount,
                notificationMethod: notificationMethod,
              );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
