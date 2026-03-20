import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/funds/presentation/widgets/balance/balance_card.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/pump_funds_app.dart';

Finder _drawerTile(String label) {
  return find.descendant(
    of: find.byType(Drawer),
    matching: find.text(label),
  );
}

void main() {
  group('Funds app — home', () {
    testWidgets('muestra cabecera, sección de fondos y datos mock', (
      tester,
    ) async {
      await pumpFundsApp(tester);

      expect(find.text('BTG Fondos'), findsWidgets);
      expect(find.text('Fondos disponibles'), findsOneWidget);
      expect(
        find.text(
          'Elige un fondo y suscríbete respetando el monto mínimo indicado.',
        ),
        findsOneWidget,
      );
      expect(find.text('FPV_BTG_PACTUAL_RECAUDADORA'), findsOneWidget);
      expect(find.text('DEUDAPRIVADA'), findsOneWidget);
      expect(find.text('Suscribir'), findsWidgets);
    });

    testWidgets('layout estrecho: saldo en tarjeta bajo el header', (
      tester,
    ) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        await pumpFundsApp(
          tester,
          surfaceSize: const Size(400, 900),
        );

        expect(find.text('Saldo disponible'), findsOneWidget);
        expect(find.byType(BalanceCard), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('layout ancho: sin BalanceCard en inicio (saldo en cabecera)',
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      try {
        await pumpFundsApp(
          tester,
          surfaceSize: const Size(1200, 900),
        );

        expect(find.text('Saldo disponible'), findsOneWidget);
        expect(find.byType(BalanceCard), findsNothing);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });
  });

  group('Funds app — drawer y rutas', () {
    testWidgets('drawer navega a Mis participaciones', (tester) async {
      await pumpFundsApp(tester);

      await tester.tap(find.byTooltip('Abrir menú'));
      await tester.pumpAndSettle();

      await tester.tap(_drawerTile('Mis participaciones'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Consulta tus posiciones y cancela parcial o totalmente cuando lo necesites.',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Aún no tienes participaciones activas.'),
        findsOneWidget,
      );
    });

    testWidgets('drawer navega a Historial', (tester) async {
      await pumpFundsApp(tester);

      await tester.tap(find.byTooltip('Abrir menú'));
      await tester.pumpAndSettle();

      await tester.tap(_drawerTile('Historial'));
      await tester.pumpAndSettle();

      expect(find.text('Historial de transacciones'), findsOneWidget);
      expect(
        find.text('Cuando realices movimientos, aparecerán aquí.'),
        findsOneWidget,
      );
    });

    testWidgets('drawer vuelve a Fondos', (tester) async {
      await pumpFundsApp(tester);

      await tester.tap(find.byTooltip('Abrir menú'));
      await tester.pumpAndSettle();
      await tester.tap(_drawerTile('Historial'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Abrir menú'));
      await tester.pumpAndSettle();
      await tester.tap(_drawerTile('Fondos'));
      await tester.pumpAndSettle();

      expect(find.text('Fondos disponibles'), findsOneWidget);
    });
  });

  group('Funds app — diálogo suscripción', () {
    testWidgets('abre diálogo y lo cierra con Cancelar', (tester) async {
      await pumpFundsApp(tester);

      await tester.tap(find.text('Suscribir').first);
      await tester.pumpAndSettle();

      expect(find.text('Suscribir a fondo'), findsOneWidget);
      expect(find.text('Método de notificación'), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(find.text('Suscribir a fondo'), findsNothing);
    });
  });
}
