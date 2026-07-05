import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/l10n/locale_cubit.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(title: l10n.chooseLanguage),
              BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(l10n.chooseLanguage),
                    subtitle: Text(locale.languageCode == 'en' ? l10n.english : l10n.russian),
                    onTap: () => _showLanguageDialog(context, locale),
                  );
                },
              ),
              const Divider(height: 40),
              _SectionHeader(title: l10n.theme),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: Text(l10n.theme),
                    subtitle: Text(_getThemeName(context, themeMode)),
                    onTap: () => _showThemeDialog(context, themeMode),
                  );
                },
              ),
              const Divider(height: 40),
              _SectionHeader(title: l10n.user),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(l10n.user),
                subtitle: Text(l10n.loggedIn),
                trailing: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  onPressed: () async {
                    await context.read<AuthCubit>().signOut();
                    if (context.mounted) context.go('/login');
                  },
                ),
              ),
              const Divider(height: 40),
              _SectionHeader(title: l10n.appName),
              ListTile(
                title: Text(l10n.version),
                trailing: const Text('1.0.0'),
              ),
              ListTile(
                title: Text(l10n.madeWithLove),
              ),
              const Divider(height: 40),
              OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(l10n.signOut, style: const TextStyle(color: Colors.red)),
                onPressed: () async {
                  await context.read<AuthCubit>().signOut();
                  if (context.mounted) context.go('/login');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, Locale currentLocale) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.chooseLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<Locale>(
              title: Text(l10n.russian),
              value: const Locale('ru'),
              groupValue: currentLocale,
              onChanged: (val) {
                if (val != null) context.read<LocaleCubit>().setLocale(val);
                Navigator.pop(context);
              },
            ),
            RadioListTile<Locale>(
              title: Text(l10n.english),
              value: const Locale('en'),
              groupValue: currentLocale,
              onChanged: (val) {
                if (val != null) context.read<LocaleCubit>().setLocale(val);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeMode currentMode) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.chooseTheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(l10n.systemTheme),
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) context.read<ThemeCubit>().updateTheme(val);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n.lightTheme),
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) context.read<ThemeCubit>().updateTheme(val);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n.darkTheme),
              value: ThemeMode.dark,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) context.read<ThemeCubit>().updateTheme(val);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeName(BuildContext context, ThemeMode mode) {
    final l10n = AppLocalizations.of(context);
    switch (mode) {
      case ThemeMode.system:
        return l10n.systemTheme;
      case ThemeMode.light:
        return l10n.lightTheme;
      case ThemeMode.dark:
        return l10n.darkTheme;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
