import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/providers/fund_actions_provider.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_empty_state.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_error_display.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_loading_placeholder.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_section_title.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/dialogs/cancel_dialog.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/participations/participation_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipationsSection extends ConsumerWidget {
  const ParticipationsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participationsAsync = ref.watch(participationsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FundSectionTitle(
          icon: Icons.pie_chart_outline_rounded,
          title: 'Mis participaciones',
          subtitle:
              'Consulta tus posiciones y cancela parcial o totalmente cuando lo necesites.',
        ),
        const SizedBox(height: FundLayout.blockGap),
        participationsAsync.when(
          data: (participations) {
            if (participations.isEmpty) {
              return const FundEmptyState(
                message: 'Aún no tienes participaciones activas.',
                icon: Icons.inbox_outlined,
              );
            }
            return Column(
              children: [
                for (var i = 0; i < participations.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  ParticipationCard(
                    participation: participations[i],
                    onCancel: () => _showCancelDialog(
                      context,
                      ref,
                      participations[i],
                    ),
                  ),
                ],
              ],
            );
          },
          loading: () => const FundLoadingPlaceholder(height: 160),
          error: (e, _) => FundErrorDisplay(message: e.toString()),
        ),
      ],
    );
  }

  void _showCancelDialog(
    BuildContext context,
    WidgetRef ref,
    Participation participation,
  ) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CancelDialog(
        participation: participation,
        onCancel: (amount) {
          ref.read(fundActionsProvider.notifier).cancel(
                fundId: participation.fundId,
                fundName: participation.fundName,
                amount: amount,
              );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
