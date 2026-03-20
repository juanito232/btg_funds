import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_1/data/datasources/local_fund_datasource_impl.dart';
import 'package:flutter_application_1/domain/datasources/local_fund_datasource.dart';
import 'package:flutter_application_1/data/repositories/balance_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/fund_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/domain/repositories/balance_repository.dart';
import 'package:flutter_application_1/domain/repositories/fund_repository.dart';
import 'package:flutter_application_1/domain/repositories/transaction_repository.dart';

/// Misma instancia de datasource para saldo, transacciones y fondos.
final localFundDataSourceProvider = Provider<LocalFundDataSource>(
  (ref) => LocalFundDataSourceImpl(),
);

// Repositories
final fundRepositoryProvider = Provider<FundRepository>((ref) {
  final dataSource = ref.watch(localFundDataSourceProvider);
  return FundRepositoryImpl(dataSource);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final dataSource = ref.watch(localFundDataSourceProvider);
  return TransactionRepositoryImpl(dataSource);
});

final balanceRepositoryProvider = Provider<BalanceRepository>((ref) {
  final dataSource = ref.watch(localFundDataSourceProvider);
  return BalanceRepositoryImpl(dataSource);
});

// Funds list
final fundsProvider = FutureProvider<List<Fund>>((ref) async {
  final repository = ref.watch(fundRepositoryProvider);
  return repository.getAvailableFunds();
});

// Balance
final balanceProvider = FutureProvider<double>((ref) async {
  final repository = ref.watch(balanceRepositoryProvider);
  return repository.getAvailableBalance();
});

// Participations
final participationsProvider = FutureProvider<List<Participation>>((ref) async {
  final repository = ref.watch(balanceRepositoryProvider);
  return repository.getParticipations();
});

// Transaction history
final transactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.getTransactionHistory();
});
