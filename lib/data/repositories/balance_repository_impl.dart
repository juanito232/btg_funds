import 'package:flutter_application_1/domain/datasources/local_fund_datasource.dart';
import 'package:flutter_application_1/domain/entities/participation.dart';
import 'package:flutter_application_1/domain/repositories/balance_repository.dart';

/// Implementación del repositorio de saldo - Capa de Datos
class BalanceRepositoryImpl implements BalanceRepository {
  BalanceRepositoryImpl(this._dataSource);

  final LocalFundDataSource _dataSource;

  @override
  Future<double> getAvailableBalance() async {
    return _dataSource.getAvailableBalance();
  }

  @override
  Future<List<Participation>> getParticipations() async {
    return _dataSource.getParticipations();
  }
}
