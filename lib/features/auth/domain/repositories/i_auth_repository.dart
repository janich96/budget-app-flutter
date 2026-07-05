import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

/// Базовая сущность пользователя для приложения
class AppUser {
  final String id;
  final String? email;
  final String? displayName;

  AppUser({required this.id, this.email, this.displayName});
}

/// Интерфейс репозитория авторизации
abstract interface class IAuthRepository {
  /// Текущий стрим состояния юзера (null = не авторизован / демо-режим)
  Stream<AppUser?> get authStateChanges;

  /// Текущий пользователь синхронно
  AppUser? get currentUser;

  /// Войти через Google
  Future<Either<Failure, AppUser>> signInWithGoogle();

  /// Войти анонимно (демо-режим / гость в облаке, если нужно)
  /// Но мы будем использовать SharedPreferences для демо,
  /// так что здесь просто для полноты картины.
  Future<Either<Failure, AppUser>> signInAnonymously();

  /// Выйти из аккаунта
  Future<Either<Failure, Unit>> signOut();
}
