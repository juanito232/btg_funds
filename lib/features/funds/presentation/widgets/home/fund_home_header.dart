import 'package:flutter/material.dart';

import 'package:flutter_application_1/features/funds/presentation/widgets/home/fund_header_balance.dart';

/// Cabecera con marca, menú (drawer) y saldo opcional en layout amplio / escritorio.
class FundHomeHeader extends StatelessWidget {
  const FundHomeHeader({
    super.key,
    required this.isWide,
    required this.showMenuButton,
    required this.showBalanceInHeader,
  });

  final bool isWide;
  final bool showMenuButton;
  final bool showBalanceInHeader;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 20,
            vertical: isWide ? 28 : 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showMenuButton) ...[
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: 'Abrir menú',
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                const SizedBox(width: 4),
              ],
              Semantics(
                label: 'Logo BTG Fondos',
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BTG Fondos',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'FPV / FIC — Gestión de fondos',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
              if (showBalanceInHeader) ...[
                const SizedBox(width: 16),
                const FundHeaderBalance(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
