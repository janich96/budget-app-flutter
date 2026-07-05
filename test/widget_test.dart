import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:budget_app/main.dart';
import 'package:budget_app/core/di/injection.dart';
import 'package:budget_app/core/router/app_router.dart';
import 'package:budget_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:budget_app/features/finance_tracker/domain/repositories/i_finance_repository.dart';
import 'package:budget_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

// Фейковый репозиторий авторизации
class FakeAuthRepository extends Fake implements IAuthRepository {
  @override
  Stream<AppUser?> get authStateChanges => Stream.value(null);

  @override
  AppUser? get currentUser => null;

  @override
  Future<Either<Failure, AppUser>> signInWithGoogle() async {
    return right(AppUser(id: 'test_user', displayName: 'Test User'));
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return right(unit);
  }
}

// Фейковый репозиторий финансов
class FakeFinanceRepository extends Fake implements IFinanceRepository {
  @override
  Future<Either<Failure, List<Never>>> getExpenseCategories() async => right([]);

  @override
  Future<Either<Failure, List<Never>>> getAccumulationCategories() async => right([]);

  @override
  Future<Either<Failure, List<Never>>> getAllWeekEntries() async => right([]);
}

void main() {
  // Очищаем GetIt перед каждым тестом, чтобы избежать ошибок "Already registered"
  setUp(() async {
    await getIt.reset();

    // Регистрируем фейковые версии вместо реальных Firebase-репозиториев
    getIt.registerLazySingleton<IAuthRepository>(() => FakeAuthRepository());
    getIt.registerLazySingleton<IFinanceRepository>(() => FakeFinanceRepository());

    // Сбрасываем роутер на начальную позицию (поскольку appRouter глобальный)
    appRouter.go('/login');
  });

  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Budget Tracker'), findsOneWidget);
    expect(find.text('Войти через Google'), findsOneWidget);
    expect(find.text('Попробовать Демо-режим'), findsOneWidget);
  });

  testWidgets('Clicking Demo Mode navigates to Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final demoButton = find.text('Попробовать Демо-режим');
    await tester.tap(demoButton);
    await tester.pumpAndSettle();

    // "Сводка" есть и в заголовке, и в меню, поэтому проверяем наличие хотя бы одного
    expect(find.text('Сводка'), findsAtLeastNWidgets(1));
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
  });

  testWidgets('Clicking Google Sign In navigates to Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final googleButton = find.text('Войти через Google');
    await tester.tap(googleButton);
    await tester.pumpAndSettle();

    expect(find.text('Сводка'), findsAtLeastNWidgets(1));
  });
}
