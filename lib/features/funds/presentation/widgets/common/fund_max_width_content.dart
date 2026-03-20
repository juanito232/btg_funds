import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/funds/presentation/constants/fund_layout.dart';

/// Centra y limita el ancho del contenido en viewports anchos.
class FundMaxWidthContent extends StatelessWidget {
  const FundMaxWidthContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: FundLayout.maxContentWidth),
        child: child,
      ),
    );
  }
}
