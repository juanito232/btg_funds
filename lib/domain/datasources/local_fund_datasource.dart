import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';

abstract class LocalFundDataSource {
  Future<List<Fund>> getFunds();

  Future<double> getAvailableBalance();

  Future<List<Participation>> getParticipations();

  Future<List<Transaction>> getTransactions();

  Future<void> subscribe(
    String fundId,
    String fundName,
    double amount,
    NotificationMethod notificationMethod,
  );

  Future<void> cancel(String fundId, String fundName, double amount);
}
