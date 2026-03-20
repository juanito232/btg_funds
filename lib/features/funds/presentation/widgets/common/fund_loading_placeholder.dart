import 'package:flutter/material.dart';

/// Indicador de carga con región semántica para lectores de pantalla.
class FundLoadingPlaceholder extends StatelessWidget {
  const FundLoadingPlaceholder({super.key, this.height = 120});

  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Cargando contenido',
      excludeSemantics: false,
      child: SizedBox(
        height: height,
        child: Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: scheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
