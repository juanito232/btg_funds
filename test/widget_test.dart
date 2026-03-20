import 'package:flutter_test/flutter_test.dart';

import 'support/pump_funds_app.dart';

void main() {
  testWidgets('App carga cabecera y listado de fondos', (tester) async {
    await pumpFundsApp(tester);

    expect(find.text('BTG Fondos'), findsWidgets);
    expect(find.text('Fondos disponibles'), findsOneWidget);
  });
}
