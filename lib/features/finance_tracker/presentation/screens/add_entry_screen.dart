import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:budget_app/core/presentation/widgets/bouncy_tap.dart';
import '../../domain/entities/week_entry.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class AddEntryScreen extends StatefulWidget {
  final WeekEntry? initialEntry;
  const AddEntryScreen({super.key, this.initialEntry});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startDate;
  late DateTime _endDate;

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialEntry != null) {
      _startDate = widget.initialEntry!.startDate;
      _endDate = widget.initialEntry!.endDate;
      widget.initialEntry!.expenses.forEach((key, value) {
        _controllers[key] = TextEditingController(text: value.toString());
      });
    } else {
      _startDate =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
      _endDate =
          DateTime.now().add(Duration(days: 7 - DateTime.now().weekday));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      // Сокращаем до минимума для максимальной плавности
      firstDate: DateTime(now.year - 2), 
      lastDate: DateTime(now.year + 1),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final state = context.read<FinanceCubit>().state;
      state.maybeWhen(
        loaded: (expenses, _, __) {
          final Map<String, double> enteredExpenses = {};
          final Map<String, double> limitSnapshots = {};
          final Map<String, String> linkSnapshots = {};

          for (var expense in expenses) {
            final valStr = _controllers[expense.id]?.text ?? '0';
            final val = double.tryParse(valStr) ?? 0.0;
            enteredExpenses[expense.id] = val;
            limitSnapshots[expense.id] = expense.limit;
            if (expense.linkedAccumulationId != null) {
              linkSnapshots[expense.id] = expense.linkedAccumulationId!;
            }
          }

          final entry = WeekEntry(
            id: widget.initialEntry?.id ??
                DateTime.now().millisecondsSinceEpoch.toString(),
            startDate: _startDate,
            endDate: _endDate,
            expenses: enteredExpenses,
            limitsSnapshot: limitSnapshots,
            linksSnapshot: linkSnapshots,
          );

          context.read<FinanceCubit>().addWeekEntry(entry);

          final snackBar = SnackBar(
            content: Text(widget.initialEntry != null
                ? 'Запись успешно обновлена!'
                : 'Запись успешно добавлена!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Если это было добавление новой записи через вкладку, очищаем поля
          if (widget.initialEntry == null) {
            setState(() {
              for (var controller in _controllers.values) {
                controller.clear();
              }
              _startDate = DateTime.now()
                  .subtract(Duration(days: DateTime.now().weekday - 1));
              _endDate = DateTime.now()
                  .add(Duration(days: 7 - DateTime.now().weekday));
            });
          }

          // Если мы пришли сюда с другого экрана (редактирование), возвращаемся назад.
          // Если это была отдельная вкладка "Добавить", переходим на сводку.
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/dashboard');
          }
        },
        orElse: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.initialEntry != null ? 'Редактировать расход' : 'Добавить расход',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<FinanceCubit, FinanceState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(
                child: Text('Ошибка: $m',
                    style: const TextStyle(color: Colors.red))),
            loaded: (expenses, accumulations, entries) {
              if (expenses.isEmpty) {
                return const Center(
                    child:
                        Text('Нет категорий трат. Добавьте их в настройках.'));
              }

              // Инициализация контроллеров для каждой категории
              for (var exp in expenses) {
                _controllers.putIfAbsent(exp.id, () => TextEditingController());
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    BouncyTap(
                      onTap: () => _pickDateRange(context),
                      child: Card(
                        child: ListTile(
                          mouseCursor: SystemMouseCursors.click,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.calendar_month_outlined),
                          ),
                          title: const Text('Период трат',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${_startDate.day}.${_startDate.month}.${_startDate.year} - ${_endDate.day}.${_endDate.month}.${_endDate.year}'),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Фактические траты по категориям:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...expenses.asMap().entries.map((entry) {
                      final index = entry.key;
                      final expense = entry.value;
                      final isLast = index == expenses.length - 1;

                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 300 + (index * 50)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.easeOut,
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(offset: Offset(0, 10 * (1 - value)), child: child),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              controller: _controllers[expense.id],
                              decoration: InputDecoration(
                                labelText: expense.name,
                                labelStyle: TextStyle(color: Color(expense.colorValue)),
                                hintText: 'Лимит: ${expense.limit} ₽',
                                prefixIcon: Icon(Icons.payments_outlined, color: Color(expense.colorValue)),
                              ),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              textInputAction:
                                  isLast ? TextInputAction.done : TextInputAction.next,
                              onFieldSubmitted: (_) {
                                if (isLast) {
                                  _submitForm();
                                }
                              },
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  if (double.tryParse(value) == null) {
                                    return 'Введите корректное число';
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    BouncyTap(
                      onTap: _submitForm,
                      child: IgnorePointer(
                        child: FilledButton(
                          onPressed: () {}, // Make sure it looks enabled
                          child: const Text('Сохранить',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
            orElse: () => const Center(child: Text('Инициализация...')),
          );
        },
      ),
    );
  }
}
