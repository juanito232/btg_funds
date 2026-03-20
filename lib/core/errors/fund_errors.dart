import 'package:flutter_application_1/core/utils/currency_formatter.dart';

sealed class FundError {
  const FundError();
}

class InsufficientBalanceError extends FundError {
  const InsufficientBalanceError({
    required this.requiredAmount,
    required this.availableBalance,
  });

  final double requiredAmount;
  final double availableBalance;

  @override
  String toString() =>
      'Saldo insuficiente. Requerido: ${formatCop(requiredAmount, decimals: true)}, '
      'Disponible: ${formatCop(availableBalance, decimals: true)}';
}

class MinimumAmountError extends FundError {
  const MinimumAmountError({
    required this.minimumAmount,
    required this.enteredAmount,
  });

  final double minimumAmount;
  final double enteredAmount;

  @override
  String toString() =>
      'El monto mínimo para este fondo es ${formatCop(minimumAmount, decimals: true)}. '
      'Ingresado: ${formatCop(enteredAmount, decimals: true)}';
}
