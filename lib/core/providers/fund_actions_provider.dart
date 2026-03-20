import 'package:flutter_application_1/data/repositories/balance_repository_impl.dart';
import 'package:flutter_application_1/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_application_1/domain/entities/transaction.dart';
import 'package:flutter_application_1/domain/repositories/balance_repository.dart';
import 'package:flutter_application_1/domain/repositories/transaction_repository.dart';
import 'package:flutter_application_1/core/errors/fund_errors.dart';
import 'package:flutter_application_1/core/utils/currency_formatter.dart';
import 'package:flutter_application_1/core/providers/fund_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final fundActionsProvider =
    StateNotifierProvider<FundActionsNotifier, FundActionsState>((ref) {
      final dataSource = ref.watch(localFundDataSourceProvider);
      return FundActionsNotifier(
        transactionRepository: TransactionRepositoryImpl(dataSource),
        balanceRepository: BalanceRepositoryImpl(dataSource),
        ref: ref,
      );
    });

class FundActionsState {
  const FundActionsState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  final bool isLoading;
  final String? error;
  final String? successMessage;

  FundActionsState copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) => FundActionsState(
    isLoading: isLoading ?? this.isLoading,
    error: error,
    successMessage: successMessage,
  );
}

class FundActionsNotifier extends StateNotifier<FundActionsState> {
  FundActionsNotifier({
    required this.transactionRepository,
    required this.balanceRepository,
    required this.ref,
  }) : super(const FundActionsState());

  final TransactionRepository transactionRepository;
  final BalanceRepository balanceRepository;
  final Ref ref;

  Future<void> subscribe({
    required String fundId,
    required String fundName,
    required double minimumAmount,
    required double amount,
    required NotificationMethod notificationMethod,
  }) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      final balance = await balanceRepository.getAvailableBalance();

      if (amount < minimumAmount) {
        state = state.copyWith(
          isLoading: false,
          error: MinimumAmountError(
            minimumAmount: minimumAmount,
            enteredAmount: amount,
          ).toString(),
        );
        return;
      }

      if (amount > balance) {
        state = state.copyWith(
          isLoading: false,
          error: InsufficientBalanceError(
            requiredAmount: amount,
            availableBalance: balance,
          ).toString(),
        );
        return;
      }

      await transactionRepository.subscribe(
        fundId: fundId,
        fundName: fundName,
        amount: amount,
        notificationMethod: notificationMethod,
      );

      ref.invalidate(balanceProvider);
      ref.invalidate(fundsProvider);
      ref.invalidate(participationsProvider);
      ref.invalidate(transactionsProvider);

      state = state.copyWith(
        isLoading: false,
        successMessage:
            'Suscripción exitosa a $fundName por ${formatCop(amount, decimals: true)}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al procesar la suscripción: $e',
      );
    }
  }

  Future<void> cancel({
    required String fundId,
    required String fundName,
    required double amount,
  }) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      await transactionRepository.cancel(
        fundId: fundId,
        fundName: fundName,
        amount: amount,
      );

      ref.invalidate(balanceProvider);
      ref.invalidate(participationsProvider);
      ref.invalidate(transactionsProvider);

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Cancelación exitosa. Saldo actualizado.',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al procesar la cancelación: $e',
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(error: null, successMessage: null);
  }
}
