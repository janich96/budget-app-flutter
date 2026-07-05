import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../models/accumulation_category_model.dart';
import '../models/expense_category_model.dart';
import '../models/week_entry_model.dart';

/// Локальная реализация репозитория (Демо-режим)
class LocalFinanceRepository implements IFinanceRepository {
  final SharedPreferences prefs;

  LocalFinanceRepository(this.prefs);

  static const _expensesKey = 'expense_categories_db';
  static const _accumulationsKey = 'accumulation_categories_db';
  static const _entriesKey = 'week_entries_db';

  // --- Helpers to read/write raw JSON from SharedPreferences ---
  List<Map<String, dynamic>> _readList(String key) {
    final strList = prefs.getStringList(key) ?? [];
    return strList
        .map((str) => jsonDecode(str) as Map<String, dynamic>)
        .toList();
  }

  Future<void> _writeList(String key, List<Map<String, dynamic>> items) async {
    final strList = items.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(key, strList);
  }

  // ================= EXPENSES =================

  @override
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories() async {
    try {
      final jsonList = _readList(_expensesKey);
      final models =
          jsonList.map((json) => ExpenseCategoryModel.fromJson(json)).toList();
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(LocalStorageFailure('Failed to load expense categories: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveExpenseCategory(
      ExpenseCategory category) async {
    try {
      final jsonList = _readList(_expensesKey);
      final newModel = ExpenseCategoryModel.fromEntity(category);
      // Remove old if exists
      jsonList.removeWhere((json) => json['id'] == category.id);
      jsonList.add(newModel.toJson());
      await _writeList(_expensesKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure('Failed to save expense category: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExpenseCategory(String id) async {
    try {
      final jsonList = _readList(_expensesKey);
      jsonList.removeWhere((json) => json['id'] == id);
      await _writeList(_expensesKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure('Failed to delete expense category: $e'));
    }
  }

  // ================= ACCUMULATIONS =================

  @override
  Future<Either<Failure, List<AccumulationCategory>>>
      getAccumulationCategories() async {
    try {
      final jsonList = _readList(_accumulationsKey);
      final models = jsonList
          .map((json) => AccumulationCategoryModel.fromJson(json))
          .toList();
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(
          LocalStorageFailure('Failed to load accumulation categories: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAccumulationCategory(
      AccumulationCategory category) async {
    try {
      final jsonList = _readList(_accumulationsKey);
      final newModel = AccumulationCategoryModel.fromEntity(category);
      jsonList.removeWhere((json) => json['id'] == category.id);
      jsonList.add(newModel.toJson());
      await _writeList(_accumulationsKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(
          LocalStorageFailure('Failed to save accumulation category: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccumulationCategory(String id) async {
    try {
      final jsonList = _readList(_accumulationsKey);
      jsonList.removeWhere((json) => json['id'] == id);
      await _writeList(_accumulationsKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(
          LocalStorageFailure('Failed to delete accumulation category: $e'));
    }
  }

  // ================= WEEK ENTRIES =================

  @override
  Future<Either<Failure, List<WeekEntry>>> getAllWeekEntries() async {
    try {
      final jsonList = _readList(_entriesKey);
      final models =
          jsonList.map((json) => WeekEntryModel.fromJson(json)).toList();
      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(LocalStorageFailure('Failed to load week entries: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addWeekEntry(WeekEntry entry) async {
    try {
      final jsonList = _readList(_entriesKey);
      final newModel = WeekEntryModel.fromEntity(entry);
      // If we are updating an existing entry, remove it first
      jsonList.removeWhere((json) => json['id'] == entry.id);
      jsonList.add(newModel.toJson());
      await _writeList(_entriesKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure('Failed to add week entry: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWeekEntry(String id) async {
    try {
      final jsonList = _readList(_entriesKey);
      jsonList.removeWhere((json) => json['id'] == id);
      await _writeList(_entriesKey, jsonList);
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure('Failed to delete week entry: $e'));
    }
  }
}
