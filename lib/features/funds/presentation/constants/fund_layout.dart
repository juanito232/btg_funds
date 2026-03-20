import 'package:flutter/material.dart';

/// Espaciado y límites de layout coherentes en la feature fondos.
abstract final class FundLayout {
  static const double sectionGap = 32;
  static const double blockGap = 16;
  static const double cardRadius = 16;
  static const double tileRadius = 12;

  /// Ancho máximo del contenido en pantallas grandes (legibilidad).
  static const double maxContentWidth = 960;

  static EdgeInsets pagePadding(bool isWide) => EdgeInsets.symmetric(
        horizontal: isWide ? 48 : 16,
        vertical: isWide ? 28 : 20,
      );
}
