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
import 'add_entry_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _formatDate(DateTime d) => DateFormat('dd.MM.yyyy').format(d);
  String _formatCurrency(double v) =>
      NumberFormat.simpleCurrency(locale: 'ru_RU').format(v);

  String _generateCsv(List<ExpenseCategory> expenses, List<WeekEntry> entries) {
    final buffer = StringBuffer();
    // Header
    buffer.write('Неделя Начало,Неделя Конец');
    for (var e in expenses) {
      buffer.write(
          ',${e.name} (лимит ${e.limit}),${e.name} (трата),${e.name} (остаток)');
    }
    buffer.writeln();
    // Rows
    for (var entry in entries) {
      buffer.write(
          '${_formatDate(entry.startDate)},${_formatDate(entry.endDate)}');
      for (var e in expenses) {
        final limit = entry.limitsSnapshot[e.id] ?? 0.0;
        final spent = entry.expenses[e.id] ?? 0.0;
        final remainder = limit - spent;
        buffer.write(',$limit,$spent,$remainder');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }

  void _showDetails(
      BuildContext context, WeekEntry entry, List<ExpenseCategory> expenses, List<AccumulationCategory> accumulations) {
    // Собираем все ID категорий, которые есть в этой записи (даже если они удалены)
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                        label: const Text('Редактировать'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(modalContext);
                          _confirmDelete(context, entry);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text('Удалить'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  ...allCategoryIds.map((catId) {
                    final exp = expenses.cast<ExpenseCategory?>().firstWhere(
                          (e) => e?.id == catId,
                          orElse: () => null,
                        );
                    
                    final name = exp?.name ?? 'Удаленная категория';
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
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.payments_outlined, color: color),
                      ),
                      title: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Лимит: ${_formatCurrency(limit)}', style: TextStyle(color: color.withOpacity(0.85), fontSize: 15, fontWeight: FontWeight.w500)),
                          if (linkedAcc != null && remainder > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Направлено в: ${linkedAcc.name}',
                                style: TextStyle(color: color.withOpacity(0.7), fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          if (exp == null)
                             const Text('(Категория была удалена)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Потрачено: ${_formatCurrency(spent)}', style: TextStyle(color: color.withOpacity(0.9), fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(
                            'Остаток: ${_formatCurrency(remainder)}',
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: Text(
            'Вы уверены, что хотите удалить запись за период ${_formatDate(entry.startDate)} — ${_formatDate(entry.endDate)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<FinanceCubit>().deleteWeekEntry(entry.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Запись удалена')),
              );
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          BlocBuilder<FinanceCubit, FinanceState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (expenses, _, entries) => IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: 'Экспорт CSV',
                  onPressed: () async {
                    final csv = _generateCsv(expenses, entries);
                    await Share.share(csv,
                        subject:
                            'Бюджет_${DateFormat('yyyy-MM').format(DateTime.now())}.csv');
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
            error: (m) => Center(
                child: Text('Ошибка: $m',
                    style: const TextStyle(color: Colors.red))),
            loaded: (expenses, accumulations, entries) {
              if (entries.isEmpty) {
                return const Center(
                    child: Text(
                        'История пуста.\nДобавьте первую запись в разделе «Расход».',
                        textAlign: TextAlign.center));
              }
              final sortedEntries = [...entries]
                ..sort((a, b) => b.startDate.compareTo(a.startDate));
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedEntries.length,
                itemBuilder: (context, index) {
                  final entry = sortedEntries[index];
                  
                  // Считаем итоги по всем данным в записи, а не только по текущим категориям
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
                      child: Transform.translate(
                          offset: Offset(0, 15 * (1 - value)), child: child),
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
                            'Потрачено: ${_formatCurrency(totalSpent)} из ${_formatCurrency(totalLimit)}',
                            style: const TextStyle(fontSize: 14)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatCurrency(totalRemainder),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: totalRemainder >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Icon(
                              totalRemainder >= 0
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: totalRemainder >= 0
                                  ? Colors.green
                                  : Colors.red,
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
            orElse: () => const Center(child: Text('Инициализация...')),
          );
        },
      ),
    );
  }
}
