import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            // When user is authenticated or chose demo mode, go to dashboard
            authenticated: (_) => context.go('/dashboard'),
            demoMode: () => context.go('/dashboard'),
            error: (m) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(m)),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance_wallet,
                    size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                const Text('Budget Tracker',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 50),

                // Show loading indicator when processing
                state.maybeWhen(
                  loading: () => const CircularProgressIndicator(),
                  orElse: () => Column(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                        ),
                        // ignore: prefer_const_constructors
                        icon: Icon(Icons.login),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithGoogle(),
                        label: const Text('Войти через Google'),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                        ),
                        onPressed: () =>
                            context.read<AuthCubit>().enterDemoMode(),
                        child: const Text('Попробовать Демо-режим'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
