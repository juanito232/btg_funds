import 'package:flutter_application_1/domain/datasources/local_fund_datasource.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._dataSource);

  final LocalFundDataSource _dataSource;

  @override
  Future<List<Transaction>> getTransactionHistory() async {
    return _dataSource.getTransactions();
  }

  @override
  Future<Transaction> subscribe({
    required String fundId,
    required String fundName,
    required double amount,
    required NotificationMethod notificationMethod,
  }) async {
    await _dataSource.subscribe(fundId, fundName, amount, notificationMethod);
    final transactions = await _dataSource.getTransactions();
    return transactions.first;
  }

  @override
  Future<Transaction> cancel({
    required String fundId,
    required String fundName,
    required double amount,
  }) async {
    await _dataSource.cancel(fundId, fundName, amount);
    final transactions = await _dataSource.getTransactions();
    return transactions.first;
  }
}
