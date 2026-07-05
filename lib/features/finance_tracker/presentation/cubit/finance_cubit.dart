import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_finance_repository.dart';
import 'finance_state.dart';
// import domain entities indirectly via state
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';

class FinanceCubit extends Cubit<FinanceState> {
  final IFinanceRepository _repository;

  FinanceCubit(this._repository) : super(const FinanceState.initial()) {
    loadData();
  }

  Future<void> loadData() async {
    emit(const FinanceState.loading());

    final expensesResult = await _repository.getExpenseCategories();
    final accumulationsResult = await _repository.getAccumulationCategories();
    final entriesResult = await _repository.getAllWeekEntries();

    expensesResult.fold(
      (f) => emit(FinanceState.error(f.message)),
      (expenses) => accumulationsResult.fold(
        (f) => emit(FinanceState.error(f.message)),
        (accumulations) => entriesResult.fold(
          (f) => emit(FinanceState.error(f.message)),
          (entries) => emit(FinanceState.loaded(
            expenseCategories: expenses,
            accumulationCategories: accumulations,
            weekEntries: entries,
          )),
        ),
      ),
    );
  }

  Future<void> addWeekEntry(WeekEntry entry) async {
    final currentState = state;
    if (currentState.maybeMap(loaded: (_) => false, orElse: () => true)) {
      return;
    }
    emit(const FinanceState.loading());
    final result = await _repository.addWeekEntry(entry);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> deleteWeekEntry(String id) async {
    emit(const FinanceState.loading());
    final result = await _repository.deleteWeekEntry(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> saveExpenseCategory(ExpenseCategory category) async {
    final result = await _repository.saveExpenseCategory(category);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> deleteExpenseCategory(String id) async {
    final result = await _repository.deleteExpenseCategory(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> saveAccumulationCategory(AccumulationCategory category) async {
    final result = await _repository.saveAccumulationCategory(category);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> deleteAccumulationCategory(String id) async {
    final result = await _repository.deleteAccumulationCategory(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => loadData(),
    );
  }

  Future<void> subtractFromAccumulation(AccumulationCategory acc, double amount) async {
    final updatedCategory = acc.copyWith(
      currentBalance: acc.currentBalance - amount,
    );
    await saveAccumulationCategory(updatedCategory);
  }

  /// Calculates the dynamic balance for a specific accumulation category by taking its
  /// base currentBalance and adding any surplus/deficit from linked expense categories
  /// across all logged weeks based on their limit snapshots.
  double calculateDynamicAccumulationBalance(
    AccumulationCategory acc,
    List<ExpenseCategory> expenses,
    List<WeekEntry> entries,
  ) {
    double dynamicBalance = acc.currentBalance;

    for (var entry in entries) {
      entry.linksSnapshot.forEach((expenseId, linkedAccId) {
        if (linkedAccId == acc.id) {
          final limit = entry.limitsSnapshot[expenseId] ?? 0.0;
          final spent = entry.expenses[expenseId] ?? 0.0;

          final remainder = limit - spent;
          if (remainder > 0) {
            dynamicBalance += remainder;
          }
        }
      });
    }

    // Не позволяем сумме опускаться ниже нуля
    return dynamicBalance < 0 ? 0 : dynamicBalance;
  }
}
