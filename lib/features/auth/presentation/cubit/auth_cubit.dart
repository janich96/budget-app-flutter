import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _authRepository;
  StreamSubscription? _authSubscription;

  AuthCubit(this._authRepository) : super(const AuthState.initial()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    // Подписываемся на изменения в Firebase Auth (вход, авто-логин и выход)
    _authSubscription?.cancel();
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        // При запуске приложения, если юзер не входил, мы попадаем сюда
        // Изначально показываем login-экран (initial/unauthenticated).
        // Если юзер выбрал "Демо", то стейт изменится на demoMode.
        // Чтобы не сбить demoMode при обновлениях, проверяем текущий стейт
        final isDemo = state.maybeMap(
          demoMode: (_) => true,
          orElse: () => false,
        );
        if (!isDemo) {
          emit(const AuthState.initial());
        }
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthState.loading());
    final result = await _authRepository.signInWithGoogle();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> enterDemoMode() async {
    // Демо-режим, когда данные пишутся только в LocalFinanceRepository
    emit(const AuthState.demoMode());
  }

  Future<void> signOut() async {
    emit(const AuthState.loading());
    // Если мы были в демо, firebase_auth.signOut() ничего не сломает
    final result = await _authRepository.signOut();
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (_) => emit(const AuthState.initial()),
    );
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
