import 'accumulation_category.dart';
import 'expense_category.dart';
import 'week_entry.dart';

class FinanceSnapshot {
  final List<ExpenseCategory> expenseCategories;
  final List<AccumulationCategory> accumulationCategories;
  final List<WeekEntry> weekEntries;

  const FinanceSnapshot({
    required this.expenseCategories,
    required this.accumulationCategories,
    required this.weekEntries,
  });
}
