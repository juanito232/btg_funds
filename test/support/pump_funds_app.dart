import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Arranca [BtgFundsApp] y espera a que terminen cargas asíncronas (fondos, saldo, etc.).
Future<void> pumpFundsApp(
  WidgetTester tester, {
  Size surfaceSize = const Size(800, 1200),
  Duration settleTimeout = const Duration(seconds: 5),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() async {
    await tester.binding.setSurfaceSize(null);
  });

  await tester.pumpWidget(
    const ProviderScope(
      child: BtgFundsApp(),
    ),
  );
  await tester.pumpAndSettle(settleTimeout);
}
