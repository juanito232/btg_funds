import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/funds/fund_card.dart';

class FundsGrid extends StatelessWidget {
  const FundsGrid({super.key, required this.funds, required this.onSubscribe});

  final List<Fund> funds;
  final void Function(Fund) onSubscribe;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 640;
        final crossAxisCount = wide ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // Altura acorde al contenido de FundCard (nombre 2 líneas + monto grande + botón).
            mainAxisExtent: wide ? 268 : 300,
          ),
          itemCount: funds.length,
          itemBuilder: (context, index) {
            final fund = funds[index];
            return FundCard(fund: fund, onSubscribe: () => onSubscribe(fund));
          },
        );
      },
    );
  }
}
