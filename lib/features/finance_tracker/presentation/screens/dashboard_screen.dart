import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(child: Text(l10n.error(m), style: const TextStyle(color: Colors.red))),
            loaded: (expenses, accumulations, entries) {
              if (accumulations.isEmpty) {
                return Center(child: Text(l10n.noAccumulationCategories, textAlign: TextAlign.center));
              }

              double totalBalance = 0;
              final cubit = context.read<FinanceCubit>();
              for (final acc in accumulations) {
                totalBalance += cubit.calculateDynamicAccumulationBalance(acc, expenses, entries);
              }

              final sortedEntries = [...entries]..sort((a, b) => b.startDate.compareTo(a.startDate));

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  _HeaderCard(totalBalance: totalBalance),
                  const SizedBox(height: 24),
                  if (sortedEntries.isNotEmpty) ...[
                    Text(l10n.lastPeriod, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    _WeeklyProgressCard(lastEntry: sortedEntries.first, expenses: expenses),
                    const SizedBox(height: 24),
                  ],
                  Text(l10n.mySavings, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  ...accumulations.asMap().entries.map((entry) {
                    final index = entry.key;
                    final acc = entry.value;
                    final calcBalance = cubit.calculateDynamicAccumulationBalance(acc, expenses, entries);

                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 400 + (index * 100)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Opacity(opacity: value, child: child),
                        );
                      },
                      child: _AccumulationCard(
                        acc: acc,
                        calcBalance: calcBalance,
                        onSubtract: () => _showSubtractDialog(context, acc),
                      ),
                    );
                  }),
                ],
              );
            },
            orElse: () => Center(child: Text(l10n.loading)),
          );
        },
      ),
    );
  }

  void _showSubtractDialog(BuildContext context, AccumulationCategory acc) {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${l10n.deductFrom} "${acc.name}"'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l10n.amount,
            suffixText: '₽',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () {
              final amount = double.tryParse(controller.text) ?? 0.0;
              if (amount > 0) {
                context.read<FinanceCubit>().subtractFromAccumulation(acc, amount);
              }
              Navigator.pop(context);
            },
            child: Text(l10n.subtract),
          ),
        ],
      ),
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  final WeekEntry lastEntry;
  final List<ExpenseCategory> expenses;
  const _WeeklyProgressCard({required this.lastEntry, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...lastEntry.expenses.entries.map((entry) {
              final cat = expenses.firstWhere(
                (e) => e.id == entry.key,
                orElse: () => ExpenseCategory(id: '', name: l10n.removed, limit: 0, colorValue: Colors.grey.value),
              );
              final spent = entry.value;
              final limit = lastEntry.limitsSnapshot[entry.key] ?? 0.0;
              final progress = limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0.0;
              final color = Color(cat.colorValue);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text('${spent.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)} ₽', style: theme.textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: color.withOpacity(0.18),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (lastEntry.expenses.isEmpty) Center(child: Text(l10n.noWeeklyExpenses)),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final double totalBalance;
  const _HeaderCard({required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [theme.colorScheme.primaryContainer, theme.colorScheme.surface]
              : [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.generalBalance, style: TextStyle(color: isDark ? theme.colorScheme.onPrimaryContainer : Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${totalBalance.toStringAsFixed(0)} ₽',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: isDark ? theme.colorScheme.onPrimaryContainer : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: isDark ? theme.colorScheme.onPrimaryContainer : Colors.white24,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccumulationCard extends StatelessWidget {
  final AccumulationCategory acc;
  final double calcBalance;
  final VoidCallback onSubtract;

  const _AccumulationCard({
    required this.acc,
    required this.calcBalance,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = Color(acc.colorValue);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color.withOpacity(0.18), shape: BoxShape.circle),
                  child: Icon(Icons.savings_outlined, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(acc.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        acc.description ?? l10n.addSavings,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${calcBalance.toStringAsFixed(0)} ₽',
                  style: theme.textTheme.titleLarge?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (acc.targetAmount > 0) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${l10n.targetAmount}: ${acc.targetAmount.toStringAsFixed(0)} ₽', style: theme.textTheme.bodySmall),
                  Text(
                    '${((calcBalance / acc.targetAmount) * 100).clamp(0, 100).toStringAsFixed(1)}%',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (calcBalance / acc.targetAmount).clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: color.withOpacity(0.18),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onSubtract,
                icon: const Icon(Icons.remove_circle_outline, size: 18),
                label: Text(l10n.subtract),
                style: TextButton.styleFrom(
                  foregroundColor: color,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
