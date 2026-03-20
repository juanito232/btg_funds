import 'package:flutter_application_1/domain/entities/participation.dart';

abstract class BalanceRepository {
  Future<double> getAvailableBalance();

  Future<List<Participation>> getParticipations();
}
