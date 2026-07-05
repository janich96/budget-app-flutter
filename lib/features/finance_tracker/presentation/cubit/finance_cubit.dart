import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/finance_snapshot.dart';
import '../../domain/entities/week_entry.dart';
import '../../domain/repositories/i_finance_repository.dart';
import 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  final IFinanceRepository _repository;
  StreamSubscription<FinanceSnapshot>? _subscription;

  FinanceCubit(this._repository) : super(const FinanceState.initial()) {
    _watchFinanceSnapshot();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }

  Future<void> loadData() async {
    emit(const FinanceState.loading());

    final expensesResult = await _repository.getExpenseCategories();
    final accumulationsResult = await _repository.getAccumulationCategories();
    final entriesResult = await _repository.getAllWeekEntries();

    expensesResult.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (expenses) => accumulationsResult.fold(
        (failure) => emit(FinanceState.error(failure.message)),
        (accumulations) => entriesResult.fold(
          (failure) => emit(FinanceState.error(failure.message)),
          (entries) => emit(FinanceState.loaded(
            expenseCategories: expenses,
            accumulationCategories: accumulations,
            weekEntries: entries,
          )),
        ),
      ),
    );
  }

  void _watchFinanceSnapshot() {
    _subscription?.cancel();
    _subscription = _repository.watchFinanceSnapshot().listen(
      (snapshot) {
        emit(FinanceState.loaded(
          expenseCategories: snapshot.expenseCategories,
          accumulationCategories: snapshot.accumulationCategories,
          weekEntries: snapshot.weekEntries,
        ));
      },
      onError: (error) {
        emit(FinanceState.error(error.toString()));
      },
    );
  }

  FinanceSnapshot? get _snapshot => state.maybeMap(
        loaded: (loaded) => FinanceSnapshot(
          expenseCategories: List.of(loaded.expenseCategories),
          accumulationCategories: List.of(loaded.accumulationCategories),
          weekEntries: List.of(loaded.weekEntries),
        ),
        orElse: () => null,
      );

  void _emitSnapshot(FinanceSnapshot snapshot) {
    emit(FinanceState.loaded(
      expenseCategories: snapshot.expenseCategories,
      accumulationCategories: snapshot.accumulationCategories,
      weekEntries: snapshot.weekEntries,
    ));
  }

  void _updateSnapshot({
    required List<ExpenseCategory> Function(List<ExpenseCategory>) updateExpenses,
    required List<AccumulationCategory> Function(List<AccumulationCategory>) updateAccumulations,
    required List<WeekEntry> Function(List<WeekEntry>) updateEntries,
  }) {
    final snapshot = _snapshot;
    if (snapshot == null) {
      loadData();
      return;
    }

    _emitSnapshot(
      FinanceSnapshot(
        expenseCategories: updateExpenses(snapshot.expenseCategories),
        accumulationCategories: updateAccumulations(snapshot.accumulationCategories),
        weekEntries: updateEntries(snapshot.weekEntries),
      ),
    );
  }

  Future<void> addWeekEntry(WeekEntry entry) async {
    if (_snapshot == null) return;

    final result = await _repository.addWeekEntry(entry);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) => expenses,
        updateAccumulations: (accumulations) => accumulations,
        updateEntries: (entries) {
          final next = [...entries];
          final index = next.indexWhere((item) => item.id == entry.id);
          if (index == -1) {
            next.add(entry);
          } else {
            next[index] = entry;
          }
          next.sort((a, b) => b.startDate.compareTo(a.startDate));
          return next;
        },
      ),
    );
  }

  Future<void> deleteWeekEntry(String id) async {
    final result = await _repository.deleteWeekEntry(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) => expenses,
        updateAccumulations: (accumulations) => accumulations,
        updateEntries: (entries) => entries.where((entry) => entry.id != id).toList(),
      ),
    );
  }

  Future<void> saveExpenseCategory(ExpenseCategory category) async {
    final result = await _repository.saveExpenseCategory(category);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) {
          final next = [...expenses];
          final index = next.indexWhere((item) => item.id == category.id);
          if (index == -1) {
            next.add(category);
          } else {
            next[index] = category;
          }
          next.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          return next;
        },
        updateAccumulations: (accumulations) => accumulations,
        updateEntries: (entries) => entries,
      ),
    );
  }

  Future<void> deleteExpenseCategory(String id) async {
    final result = await _repository.deleteExpenseCategory(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) => expenses.where((category) => category.id != id).toList(),
        updateAccumulations: (accumulations) => accumulations,
        updateEntries: (entries) => entries,
      ),
    );
  }

  Future<void> saveAccumulationCategory(AccumulationCategory category) async {
    final result = await _repository.saveAccumulationCategory(category);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) => expenses,
        updateAccumulations: (accumulations) {
          final next = [...accumulations];
          final index = next.indexWhere((item) => item.id == category.id);
          if (index == -1) {
            next.add(category);
          } else {
            next[index] = category;
          }
          next.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          return next;
        },
        updateEntries: (entries) => entries,
      ),
    );
  }

  Future<void> deleteAccumulationCategory(String id) async {
    final result = await _repository.deleteAccumulationCategory(id);
    result.fold(
      (failure) => emit(FinanceState.error(failure.message)),
      (_) => _updateSnapshot(
        updateExpenses: (expenses) => expenses,
        updateAccumulations: (accumulations) =>
            accumulations.where((category) => category.id != id).toList(),
        updateEntries: (entries) => entries,
      ),
    );
  }

  Future<void> subtractFromAccumulation(
    AccumulationCategory acc,
    double amount,
  ) async {
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

    for (final entry in entries) {
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

    return dynamicBalance < 0 ? 0 : dynamicBalance;
  }
}
