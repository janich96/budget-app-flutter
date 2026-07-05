import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/i_auth_repository.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;

  /// Авторизованный пользователь (Google)
  const factory AuthState.authenticated(AppUser user) = _Authenticated;

  /// Гость / Демо-режим (Локальное хранилище)
  const factory AuthState.demoMode() = _DemoMode;
  const factory AuthState.error(String message) = _Error;
}
