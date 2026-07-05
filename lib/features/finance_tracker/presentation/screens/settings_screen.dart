import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:budget_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:budget_app/core/theme/theme_cubit.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const _SectionHeader(title: 'Внешний вид'),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Тема приложения'),
                    subtitle: Text(_getThemeName(themeMode)),
                    onTap: () => _showThemeDialog(context, themeMode),
                  );
                },
              ),
              const Divider(height: 40),
              const _SectionHeader(title: 'Аккаунт'),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Пользователь'),
                subtitle: const Text('Вы вошли в систему'),
                trailing: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  onPressed: () async {
                    await context.read<AuthCubit>().signOut();
                    if (context.mounted) context.go('/login');
                  },
                ),
              ),
              const Divider(height: 40),
              const _SectionHeader(title: 'О приложении'),
              const ListTile(
                title: Text('Версия'),
                trailing: Text('1.0.0'),
              ),
              const ListTile(
                title: Text('Сделано с любовью к бюджету'),
              ),
              const Divider(height: 40),
              OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Выйти из аккаунта',
                    style: TextStyle(color: Colors.red)),
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

  void _showThemeDialog(BuildContext context, ThemeMode currentMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выберите тему'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Системная'),
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) context.read<ThemeCubit>().updateTheme(val);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Светлая'),
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) context.read<ThemeCubit>().updateTheme(val);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Тёмная'),
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

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Системная';
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Тёмная';
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
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
