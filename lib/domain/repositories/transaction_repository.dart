import 'package:flutter_application_1/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionHistory();

  Future<Transaction> subscribe({
    required String fundId,
    required String fundName,
    required double amount,
    required NotificationMethod notificationMethod,
  });

  Future<Transaction> cancel({
    required String fundId,
    required String fundName,
    required double amount,
  });
}
