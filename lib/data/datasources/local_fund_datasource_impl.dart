import 'package:flutter_application_1/data/models/local_fund_model.dart';
import 'package:flutter_application_1/domain/datasources/local_fund_datasource.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/shared/data/local_funds.dart';

class LocalFundDataSourceImpl implements LocalFundDataSource {
  double _availableBalance = 500000.0;
  final List<Participation> _participations = [];
  final List<Transaction> _transactions = [];

  @override
  Future<List<Fund>> getFunds() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return localFunds
        .map((fund) => LocalFundModel.fromJsonMap(fund).toEntity())
        .toList();
  }

  @override
  Future<double> getAvailableBalance() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _availableBalance;
  }

  @override
  Future<List<Participation>> getParticipations() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_participations);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_transactions.reversed.toList());
  }

  @override
  Future<void> subscribe(
    String fundId,
    String fundName,
    double amount,
    NotificationMethod notificationMethod,
  ) async {
    _availableBalance -= amount;
    final units = amount;

    final existingIndex = _participations.indexWhere((p) => p.fundId == fundId);
    if (existingIndex >= 0) {
      final existing = _participations[existingIndex];
      _participations[existingIndex] = Participation(
        fundId: existing.fundId,
        fundName: existing.fundName,
        investedAmount: existing.investedAmount + amount,
        currentValue: existing.currentValue + amount,
        units: existing.units + units,
      );
    } else {
      _participations.add(
        Participation(
          fundId: fundId,
          fundName: fundName,
          investedAmount: amount,
          currentValue: amount,
          units: units,
        ),
      );
    }

    _transactions.add(
      Transaction(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        fundId: fundId,
        fundName: fundName,
        type: TransactionType.subscription,
        amount: amount,
        date: DateTime.now(),
        notificationMethod: notificationMethod,
      ),
    );
  }

  @override
  Future<void> cancel(String fundId, String fundName, double amount) async {
    final index = _participations.indexWhere((p) => p.fundId == fundId);
    if (index < 0) return;

    final p = _participations[index];
    final amountToCancel = amount > p.investedAmount
        ? p.investedAmount
        : amount;

    _availableBalance += amountToCancel;

    final newInvested = p.investedAmount - amountToCancel;
    final newUnits = p.units * (newInvested / p.investedAmount);
    final newCurrentValue = p.currentValue * (newInvested / p.investedAmount);

    if (newInvested <= 0) {
      _participations.removeAt(index);
    } else {
      _participations[index] = Participation(
        fundId: p.fundId,
        fundName: p.fundName,
        investedAmount: newInvested,
        currentValue: newCurrentValue,
        units: newUnits,
      );
    }

    _transactions.add(
      Transaction(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        fundId: fundId,
        fundName: fundName,
        type: TransactionType.cancellation,
        amount: amountToCancel,
        date: DateTime.now(),
        notificationMethod: NotificationMethod.email,
      ),
    );
  }
}
