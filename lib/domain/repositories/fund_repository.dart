import 'package:flutter_application_1/domain/entities/fund.dart';

abstract class FundRepository {
  Future<List<Fund>> getAvailableFunds();
}
