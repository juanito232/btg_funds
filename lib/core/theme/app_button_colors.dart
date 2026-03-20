import 'package:flutter/material.dart';

/// Colores de acción para botones rellenos (`FilledButton`), accesibles vía tema.
@immutable
class AppButtonColors extends ThemeExtension<AppButtonColors> {
  const AppButtonColors({
    required this.filledBackground,
    required this.filledForeground,
  });

  /// Fondo tipo verde bosque / acción positiva.
  final Color filledBackground;

  final Color filledForeground;

  static const Color defaultFilledBackground = Color(0xFF2E7D52);
  static const Color defaultFilledForeground = Color(0xFFFFFFFF);

  static const AppButtonColors standard = AppButtonColors(
    filledBackground: defaultFilledBackground,
    filledForeground: defaultFilledForeground,
  );

  static AppButtonColors of(BuildContext context) {
    return Theme.of(context).extension<AppButtonColors>() ?? standard;
  }

  @override
  AppButtonColors copyWith({
    Color? filledBackground,
    Color? filledForeground,
  }) {
    return AppButtonColors(
      filledBackground: filledBackground ?? this.filledBackground,
      filledForeground: filledForeground ?? this.filledForeground,
    );
  }

  @override
  AppButtonColors lerp(ThemeExtension<AppButtonColors>? other, double t) {
    if (other is! AppButtonColors) return this;
    return AppButtonColors(
      filledBackground: Color.lerp(
        filledBackground,
        other.filledBackground,
        t,
      )!,
      filledForeground: Color.lerp(
        filledForeground,
        other.filledForeground,
        t,
      )!,
    );
  }
}
