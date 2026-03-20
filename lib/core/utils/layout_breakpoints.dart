import 'package:flutter/foundation.dart';

/// Saldo en cabecera: web/escritorio en layout amplio; móvil nativo solo si el ancho es de tablet/desktop.
bool showBalanceInAppHeader(double width) {
  if (kIsWeb) return width > 900;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
    case TargetPlatform.fuchsia:
      return width > 900;
    default:
      return true;
  }
}
