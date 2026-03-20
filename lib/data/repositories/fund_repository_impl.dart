import 'package:flutter_application_1/domain/datasources/local_fund_datasource.dart';
import 'package:flutter_application_1/domain/entities/fund.dart';
import 'package:flutter_application_1/domain/repositories/fund_repository.dart';

class FundRepositoryImpl implements FundRepository {
  final LocalFundDataSource _dataSource;
  FundRepositoryImpl(this._dataSource);

  @override
  Future<List<Fund>> getAvailableFunds() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _dataSource.getFunds();
  }
}
