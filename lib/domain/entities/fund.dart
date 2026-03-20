import 'package:flutter_application_1/domain/enums/fund_type.dart';

class Fund {
  final String id;
  final String name;
  final double minimumAmount;
  final FundType type;

  const Fund({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.type,
  });
}
