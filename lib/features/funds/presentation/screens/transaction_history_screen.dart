import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/layout_breakpoints.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/common/fund_max_width_content.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/home/fund_home_header.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/transactions/transaction_history_section.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isWide = width > 900;

        return ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FundHomeHeader(
                  isWide: isWide,
                  showMenuButton: true,
                  showBalanceInHeader: showBalanceInAppHeader(width),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: FundLayout.pagePadding(isWide),
                  child: FundMaxWidthContent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const TransactionHistorySection(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
