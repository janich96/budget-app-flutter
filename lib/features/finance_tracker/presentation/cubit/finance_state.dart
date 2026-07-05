import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';

part 'finance_state.freezed.dart';

@freezed
abstract class FinanceState with _$FinanceState {
  const factory FinanceState.initial() = _Initial;
  const factory FinanceState.loading() = _Loading;

  const factory FinanceState.loaded({
    required List<ExpenseCategory> expenseCategories,
    required List<AccumulationCategory> accumulationCategories,
    required List<WeekEntry> weekEntries,
  }) = _Loaded;

  const factory FinanceState.error(String message) = _Error;
}
