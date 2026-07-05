import 'package:budget_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../../domain/entities/week_entry.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _formatDate(DateTime d) => DateFormat('dd.MM.yyyy').format(d);
  String _formatCurrency(double v) => NumberFormat.simpleCurrency(locale: 'ru_RU').format(v);

  String _generateCsv(AppLocalizations l10n, List<ExpenseCategory> expenses, List<WeekEntry> entries) {
    final buffer = StringBuffer();
    buffer.write('${l10n.weekStart},${l10n.weekEnd}');
    for (final e in expenses) {
      buffer.write(',${e.name} (${l10n.limit.toLowerCase()} ${e.limit}),${e.name} (${l10n.spent.toLowerCase()}),${e.name} (${l10n.remaining.toLowerCase()})');
    }
    buffer.writeln();
    for (final entry in entries) {
      buffer.write('${_formatDate(entry.startDate)},${_formatDate(entry.endDate)}');
      for (final e in expenses) {
        final limit = entry.limitsSnapshot[e.id] ?? 0.0;
        final spent = entry.expenses[e.id] ?? 0.0;
        final remainder = limit - spent;
        buffer.write(',$limit,$spent,$remainder');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }

  void _showDetails(BuildContext context, WeekEntry entry, List<ExpenseCategory> expenses, List<AccumulationCategory> accumulations) {
    final l10n = AppLocalizations.of(context);
    final allCategoryIds = {...entry.expenses.keys, ...entry.limitsSnapshot.keys}.toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          builder: (modalContext, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Text(
                      '${_formatDate(entry.startDate)} — ${_formatDate(entry.endDate)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(modalContext);
                          context.push('/add_entry', extra: entry);
                        },
                        icon: const Icon(Icons.edit),
                        label: Text(l10n.edit),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(modalContext);
                          _confirmDelete(context, entry);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: Text(l10n.delete),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  ...allCategoryIds.map((catId) {
                    final exp = expenses.cast<ExpenseCategory?>().firstWhere(
                          (e) => e?.id == catId,
                          orElse: () => null,
                        );
                    final name = exp?.name ?? l10n.changedCategory;
                    final color = exp != null ? Color(exp.colorValue) : Colors.grey;
                    final limit = entry.limitsSnapshot[catId] ?? 0.0;
                    final spent = entry.expenses[catId] ?? 0.0;
                    final remainder = limit - spent;
                    final linkedAccId = entry.linksSnapshot[catId];
                    final linkedAcc = accumulations.cast<AccumulationCategory?>().firstWhere(
                          (a) => a?.id == linkedAccId,
                          orElse: () => null,
                        );

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: color.withOpacity(0.18), shape: BoxShape.circle),
                        child: Icon(Icons.payments_outlined, color: color),
                      ),
                      title: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('${l10n.limit}: ${_formatCurrency(limit)}', style: TextStyle(color: color.withOpacity(0.85), fontSize: 15, fontWeight: FontWeight.w500)),
                          if (linkedAcc != null && remainder > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text('${l10n.redirectedToSavings}: ${linkedAcc.name}', style: TextStyle(color: color.withOpacity(0.7), fontSize: 14, fontStyle: FontStyle.italic)),
                            ),
                          if (exp == null)
                            Text(l10n.changedCategory, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${l10n.spent}: ${_formatCurrency(spent)}', style: TextStyle(color: color.withOpacity(0.9), fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(
                            '${l10n.remaining}: ${_formatCurrency(remainder)}',
                            style: TextStyle(
                              color: remainder >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, WeekEntry entry) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteRecord),
        content: Text('${l10n.confirmDeleteRecord} ${_formatDate(entry.startDate)} — ${_formatDate(entry.endDate)}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () {
              context.read<FinanceCubit>().deleteWeekEntry(entry.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.recordDeleted)));
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          BlocBuilder<FinanceCubit, FinanceState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (expenses, _, entries) => IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: l10n.exportCsv,
                  onPressed: () async {
                    final csv = _generateCsv(l10n, expenses, entries);
                    await Share.share(csv, subject: 'Budget_${DateFormat('yyyy-MM').format(DateTime.now())}.csv');
                  },
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(child: Text(l10n.error(m), style: const TextStyle(color: Colors.red))),
            loaded: (expenses, accumulations, entries) {
              if (entries.isEmpty) {
                return Center(child: Text(l10n.noHistoryYet, textAlign: TextAlign.center));
              }

              final sortedEntries = [...entries]..sort((a, b) => b.startDate.compareTo(a.startDate));
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedEntries.length,
                itemBuilder: (context, index) {
                  final entry = sortedEntries[index];
                  double totalLimit = 0;
                  double totalSpent = 0;
                  entry.limitsSnapshot.values.forEach((v) => totalLimit += v);
                  entry.expenses.values.forEach((v) => totalSpent += v);
                  final totalRemainder = totalLimit - totalSpent;

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (index * 50)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.translate(offset: Offset(0, 15 * (1 - value)), child: child),
                    ),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        onTap: () => _showDetails(context, entry, expenses, accumulations),
                        title: Text(
                          '${_formatDate(entry.startDate)} — ${_formatDate(entry.endDate)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${l10n.spent}: ${_formatCurrency(totalSpent)} ${l10n.limit.toLowerCase()} ${_formatCurrency(totalLimit)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatCurrency(totalRemainder),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: totalRemainder >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                            Icon(
                              totalRemainder >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                              color: totalRemainder >= 0 ? Colors.green : Colors.red,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            orElse: () => Center(child: Text(l10n.loading)),
          );
        },
      ),
    );
  }
}
