import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/finance_snapshot.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../models/accumulation_category_model.dart';
import '../models/expense_category_model.dart';
import '../models/week_entry_model.dart';

/// Firebase реализация репозитория (Для авторизованных пользователей)
class FirebaseFinanceRepository implements IFinanceRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseFinanceRepository(this._firestore, this._auth);

  /// Получаем путь до данных текущего пользователя
  DocumentReference? get _userDoc {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid);
  }

  // ================= EXPENSES =================

  @override
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories() async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final snapshot = await doc.collection('expense_categories').get();
      final models = snapshot.docs
          .map((d) => ExpenseCategoryModel.fromJson(d.data()))
          .toList();

      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(
          ServerFailure('Failed to load expense categories from Firebase: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveExpenseCategory(
      ExpenseCategory category) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final model = ExpenseCategoryModel.fromEntity(category);
      await doc
          .collection('expense_categories')
          .doc(model.id)
          .set(model.toJson());

      return right(unit);
    } catch (e) {
      return left(
          ServerFailure('Failed to save expense category to Firebase: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteExpenseCategory(String id) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      await doc.collection('expense_categories').doc(id).delete();
      return right(unit);
    } catch (e) {
      return left(
          ServerFailure('Failed to delete expense category from Firebase: $e'));
    }
  }

  // ================= ACCUMULATIONS =================

  @override
  Future<Either<Failure, List<AccumulationCategory>>>
      getAccumulationCategories() async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final snapshot = await doc.collection('accumulation_categories').get();
      final models = snapshot.docs
          .map((d) => AccumulationCategoryModel.fromJson(d.data()))
          .toList();

      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(ServerFailure('Failed to load accumulation categories: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAccumulationCategory(
      AccumulationCategory category) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final model = AccumulationCategoryModel.fromEntity(category);
      await doc
          .collection('accumulation_categories')
          .doc(model.id)
          .set(model.toJson());

      return right(unit);
    } catch (e) {
      return left(ServerFailure('Failed to save accumulation category: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAccumulationCategory(String id) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      await doc.collection('accumulation_categories').doc(id).delete();
      return right(unit);
    } catch (e) {
      return left(ServerFailure('Failed to delete accumulation category: $e'));
    }
  }

  // ================= WEEK ENTRIES =================

  @override
  Future<Either<Failure, List<WeekEntry>>> getAllWeekEntries() async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final snapshot = await doc.collection('week_entries').get();
      final models = snapshot.docs.map((d) =>
          // Firestore timestamps usually need special handling if you serialize DateTime directly,
          // but json_serializable handles string ISO 8601 automatically if configured.
          // Assuming string dates in DTO for simplicity.
          WeekEntryModel.fromJson(d.data())).toList();

      return right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return left(ServerFailure('Failed to load week entries: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addWeekEntry(WeekEntry entry) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      final model = WeekEntryModel.fromEntity(entry);

      // Merge json for safety although set overwrites.
      await doc.collection('week_entries').doc(model.id).set(model.toJson());

      return right(unit);
    } catch (e) {
      return left(ServerFailure('Failed to save week entry: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWeekEntry(String id) async {
    try {
      final doc = _userDoc;
      if (doc == null) {
        return left(const ServerFailure('User not authenticated'));
      }

      await doc.collection('week_entries').doc(id).delete();
      return right(unit);
    } catch (e) {
      return left(ServerFailure('Failed to delete week entry: $e'));
    }
  }

  @override
  Stream<FinanceSnapshot> watchFinanceSnapshot() async* {
    final doc = _userDoc;
    if (doc == null) {
      yield const FinanceSnapshot(
        expenseCategories: [],
        accumulationCategories: [],
        weekEntries: [],
      );
      return;
    }

    final controller = StreamController<FinanceSnapshot>();
    List<ExpenseCategory> expenses = const [];
    List<AccumulationCategory> accumulations = const [];
    List<WeekEntry> entries = const [];

    void emitIfReady() {
      controller.add(
        FinanceSnapshot(
          expenseCategories: expenses,
          accumulationCategories: accumulations,
          weekEntries: entries,
        ),
      );
    }

    final expenseSub = doc.collection('expense_categories').snapshots().listen((snapshot) {
      expenses = snapshot.docs
          .map((d) => ExpenseCategoryModel.fromJson(d.data()).toEntity())
          .toList();
      emitIfReady();
    });

    final accumulationSub = doc.collection('accumulation_categories').snapshots().listen((snapshot) {
      accumulations = snapshot.docs
          .map((d) => AccumulationCategoryModel.fromJson(d.data()).toEntity())
          .toList();
      emitIfReady();
    });

    final entriesSub = doc.collection('week_entries').snapshots().listen((snapshot) {
      entries = snapshot.docs.map((d) => WeekEntryModel.fromJson(d.data()).toEntity()).toList();
      emitIfReady();
    });

    controller.onCancel = () async {
      await expenseSub.cancel();
      await accumulationSub.cancel();
      await entriesSub.cancel();
      await controller.close();
    };

    yield* controller.stream;
  }
}
