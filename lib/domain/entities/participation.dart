/// Entidad que representa la participación del cliente en un fondo
class Participation {
  const Participation({
    required this.fundId,
    required this.fundName,
    required this.investedAmount,
    required this.currentValue,
    required this.units,
  });

  final String fundId;
  final String fundName;
  final double investedAmount;
  final double currentValue;
  final double units;
}
