import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/l10n/locale_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) => context.go('/dashboard'),
            demoMode: () => context.go('/dashboard'),
            error: (m) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(m)),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BlocBuilder<LocaleCubit, Locale>(
                      builder: (context, locale) {
                        final selected = locale.languageCode == 'en' ? AppLanguage.en : AppLanguage.ru;
                        return SegmentedButton<AppLanguage>(
                          style: SegmentedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 13),
                            visualDensity: VisualDensity.compact,
                          ),
                          segments: [
                            ButtonSegment(
                              value: AppLanguage.ru,
                              label: SizedBox(
                                width: 78,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(l10n.russian),
                                ),
                              ),
                            ),
                            ButtonSegment(
                              value: AppLanguage.en,
                              label: SizedBox(
                                width: 78,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(l10n.english),
                                ),
                              ),
                            ),
                          ],
                          selected: {selected},
                          onSelectionChanged: (values) {
                            final choice = values.first;
                            context.read<LocaleCubit>().setLocale(
                                  Locale(choice == AppLanguage.en ? 'en' : 'ru'),
                                );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_balance_wallet, size: 80, color: Colors.blue),
                        const SizedBox(height: 20),
                        Text(
                          l10n.appName,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        state.maybeWhen(
                          loading: () => const CircularProgressIndicator(),
                          orElse: () => Column(
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(250, 50),
                                ),
                                icon: const Icon(Icons.login),
                                onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
                                label: Text(l10n.signInWithGoogle),
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(250, 50),
                                ),
                                onPressed: () => context.read<AuthCubit>().enterDemoMode(),
                                child: Text(l10n.tryDemoMode),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
