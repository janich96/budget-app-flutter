import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

import '../../features/auth/domain/repositories/i_auth_repository.dart';
import '../../features/auth/data/repositories/firebase_auth_repository.dart';

import '../../features/finance_tracker/domain/entities/accumulation_category.dart';
import '../../features/finance_tracker/domain/entities/expense_category.dart';
import '../../features/finance_tracker/domain/entities/finance_snapshot.dart';
import '../../features/finance_tracker/domain/entities/week_entry.dart';
import '../../features/finance_tracker/domain/repositories/i_finance_repository.dart';
import '../../features/finance_tracker/data/repositories/firebase_finance_repository.dart';
import '../../features/finance_tracker/data/repositories/local_finance_repository.dart';
import '../theme/theme_cubit.dart';
import '../l10n/locale_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // 1. Core Services / Third Party
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // 2. Theme Cubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SharedPreferences>()));

  // 2b. Locale Cubit
  getIt.registerFactory<LocaleCubit>(() => LocaleCubit(getIt<SharedPreferences>()));

  // 3. Auth Repository
  getIt.registerLazySingleton<IAuthRepository>(
    // Убран второй аргумент getIt<GoogleSignIn>(), так как репозиторий его больше не принимает
    () => FirebaseAuthRepository(getIt<FirebaseAuth>()),
  );

  // 3. Finance Repository (Auth-Aware Proxy)
  getIt.registerLazySingleton<IFinanceRepository>(
    () => AuthAwareFinanceRepository(
      localRepo: LocalFinanceRepository(getIt<SharedPreferences>()),
      firebaseRepo: FirebaseFinanceRepository(
          getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
      auth: getIt<FirebaseAuth>(),
    ),
  );
}

/// Прокси-класс (паттерн Proxy), реализующий внедрение зависимостей на лету.
/// Он реализует IFinanceRepository и проксирует вызовы либо к LocalFinanceRepository,
/// либо к FirebaseFinanceRepository в зависимости от состояния авторизации.
/// Благодаря этому Cubit работает только с одним объектом IFinanceRepository
/// и не знает, что под капотом хранилище меняется на лету.
class AuthAwareFinanceRepository implements IFinanceRepository {
  final LocalFinanceRepository localRepo;
  final FirebaseFinanceRepository firebaseRepo;
  final FirebaseAuth auth;

  AuthAwareFinanceRepository({
    required this.localRepo,
    required this.firebaseRepo,
    required this.auth,
  });

  IFinanceRepository get _activeRepo {
    // Если пользователь авторизован, записываем всё в Firebase
    // Иначе (demo-режим), всё пишется локально
    if (auth.currentUser != null) {
      return firebaseRepo;
    }
    return localRepo;
  }

  @override
  Future<Either<Failure, List<ExpenseCategory>>> getExpenseCategories() =>
      _activeRepo.getExpenseCategories();

  @override
  Future<Either<Failure, Unit>> saveExpenseCategory(ExpenseCategory category) =>
      _activeRepo.saveExpenseCategory(category);

  @override
  Future<Either<Failure, Unit>> deleteExpenseCategory(String id) =>
      _activeRepo.deleteExpenseCategory(id);

  @override
  Future<Either<Failure, List<AccumulationCategory>>>
      getAccumulationCategories() => _activeRepo.getAccumulationCategories();

  @override
  Future<Either<Failure, Unit>> saveAccumulationCategory(
          AccumulationCategory category) =>
      _activeRepo.saveAccumulationCategory(category);

  @override
  Future<Either<Failure, Unit>> deleteAccumulationCategory(String id) =>
      _activeRepo.deleteAccumulationCategory(id);

  @override
  Future<Either<Failure, List<WeekEntry>>> getAllWeekEntries() =>
      _activeRepo.getAllWeekEntries();

  @override
  Future<Either<Failure, Unit>> addWeekEntry(WeekEntry entry) =>
      _activeRepo.addWeekEntry(entry);

  @override
  Future<Either<Failure, Unit>> deleteWeekEntry(String id) =>
      _activeRepo.deleteWeekEntry(id);

  @override
  Stream<FinanceSnapshot> watchFinanceSnapshot() =>
      _activeRepo.watchFinanceSnapshot();
}
