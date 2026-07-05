import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/accumulation_category.dart';
import '../entities/expense_category.dart';
import '../entities/week_entry.dart';

/// Интерфейс репозитория с динамическими категориями
abstract interface class IFinanceRepository {
  
  // -- Категории трат --
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories();
  Future<Either<Failure, Unit>> saveExpenseCategory(ExpenseCategory category);
  Future<Either<Failure, Unit>> deleteExpenseCategory(String id);

  // -- Категории накоплений --
  Future<Either<Failure, List<AccumulationCategory>>> getAccumulationCategories();
  Future<Either<Failure, Unit>> saveAccumulationCategory(AccumulationCategory category);
  Future<Either<Failure, Unit>> deleteAccumulationCategory(String id);

  // -- Записи за неделю --
  Future<Either<Failure, List<WeekEntry>>> getAllWeekEntries();
  Future<Either<Failure, Unit>> addWeekEntry(WeekEntry entry);
  Future<Either<Failure, Unit>> deleteWeekEntry(String id);
}
