import 'package:intl/intl.dart';

String formatCop(double amount, {bool decimals = false}) {
  final formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: r'COP $',
    decimalDigits: decimals ? 2 : 0,
  );
  return formatter.format(amount);
}

const String copPrefix = r'COP $ ';
