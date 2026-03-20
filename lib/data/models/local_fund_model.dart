import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/enums/fund_type.dart';

class LocalFundModel {
  final String id;
  final String name;
  final double minimumAmount;
  final FundType type;

  const LocalFundModel({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.type,
  });

  factory LocalFundModel.fromJsonMap(Map<String, dynamic> json) {
    final typeStr = json['type'].toLowerCase();
    return LocalFundModel(
      id: json['id'],
      name: json['name'],
      minimumAmount: json['minimum_amount'],
      type: FundType.values.firstWhere(
        (t) => t.name == typeStr,
        orElse: () => FundType.fpv,
      ),
    );
  }

  Fund toEntity() {
    return Fund(
      id: id,
      name: name,
      minimumAmount: minimumAmount,
      type: type,
    );
  }
}
