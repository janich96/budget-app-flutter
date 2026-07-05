import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_app/core/presentation/widgets/bouncy_tap.dart';
import '../../domain/entities/accumulation_category.dart';
import '../../domain/entities/expense_category.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Категории', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            splashBorderRadius: BorderRadius.circular(20),
            tabs: const [
              Tab(text: 'Траты'),
              Tab(text: 'Накопления'),
            ],
          ),
        ),
        body: BlocBuilder<FinanceCubit, FinanceState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (m) => Center(child: Text('Ошибка: $m')),
              loaded: (expenses, accumulations, _) {
                return TabBarView(
                  children: [
                    _ExpenseCategoriesList(expenses: expenses, accumulations: accumulations),
                    _AccumulationCategoriesList(accumulations: accumulations),
                  ],
                );
              },
              orElse: () => const Center(child: Text('Инициализация...')),
            );
          },
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final int selectedColor;
  final ValueChanged<int> onColorSelected;

  const _ColorPicker({
    required this.selectedColor,
    required this.onColorSelected,
  });

  static const List<Color> _colors = [
    Color(0xFF1E88E5), // Насыщенный синий
    Color(0xFFE53935), // Яркий красный
    Color(0xFF43A047), // Сочный зеленый
    Color(0xFFFB8C00), // Оранжевый
    Color(0xFF8E24AA), // Пурпурный
    Color(0xFF00ACC1), // Циан
    Color(0xFFD81B60), // Розовый
    Color(0xFFF9A825), // Горчичный/Желтый
    Color(0xFF3949AB), // Индиго
    Color(0xFF00897B), // Тиловый
    Color(0xFF5E35B1), // Глубокий фиолетовый
    Color(0xFFF4511E), // Глубокий оранжевый
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _colors.map((color) {
        final isSelected = selectedColor == color.value;
        return GestureDetector(
          onTap: () => onColorSelected(color.value),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: Colors.black, width: 3)
                  : Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }
}

class _ExpenseCategoriesList extends StatelessWidget {
  final List<ExpenseCategory> expenses;
  final List<AccumulationCategory> accumulations;

  const _ExpenseCategoriesList({
    required this.expenses,
    required this.accumulations,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...expenses.asMap().entries.map((entry) {
          final index = entry.key;
          final e = entry.value;
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 50)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(offset: Offset(0, 10 * (1 - value)), child: child),
            ),
            child: _ExpenseCategoryTile(category: e, accumulations: accumulations),
          );
        }),
        const SizedBox(height: 16),
        BouncyTap(
          onTap: () => _showEditExpenseDialog(context, null, accumulations),
          child: IgnorePointer(
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Добавить категорию трат'),
            ),
          ),
        ),
      ],
    );
  }

  void _showEditExpenseDialog(
      BuildContext context, ExpenseCategory? existing, List<AccumulationCategory> accumulationCategories) {
    showDialog(
      context: context,
      builder: (_) => _EditExpenseCategoryDialog(
        existing: existing,
        accumulationCategories: accumulationCategories,
        onSave: (category) => context.read<FinanceCubit>().saveExpenseCategory(category),
        onDelete: existing != null
            ? () => context.read<FinanceCubit>().deleteExpenseCategory(existing.id)
            : null,
      ),
    );
  }
}

class _AccumulationCategoriesList extends StatelessWidget {
  final List<AccumulationCategory> accumulations;

  const _AccumulationCategoriesList({required this.accumulations});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...accumulations.asMap().entries.map((entry) {
          final index = entry.key;
          final a = entry.value;
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 50)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(offset: Offset(0, 10 * (1 - value)), child: child),
            ),
            child: _AccumulationCategoryTile(category: a),
          );
        }),
        const SizedBox(height: 16),
        BouncyTap(
          onTap: () => _showEditAccumulationDialog(context, null),
          child: IgnorePointer(
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Добавить накопление'),
            ),
          ),
        ),
      ],
    );
  }

  void _showEditAccumulationDialog(BuildContext context, AccumulationCategory? existing) {
    showDialog(
      context: context,
      builder: (_) => _EditAccumulationCategoryDialog(
        existing: existing,
        onSave: (category) => context.read<FinanceCubit>().saveAccumulationCategory(category),
        onDelete: existing != null
            ? () => context.read<FinanceCubit>().deleteAccumulationCategory(existing.id)
            : null,
      ),
    );
  }
}

class _ExpenseCategoryTile extends StatelessWidget {
  final ExpenseCategory category;
  final List<AccumulationCategory> accumulations;
  const _ExpenseCategoryTile({required this.category, required this.accumulations});

  @override
  Widget build(BuildContext context) {
    final linkedAcc = accumulations.cast<AccumulationCategory?>().firstWhere(
          (a) => a?.id == category.linkedAccumulationId,
          orElse: () => null,
        );

    final color = Color(category.colorValue);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.payments_outlined, color: color),
        ),
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Лимит: ${category.limit.toStringAsFixed(0)} ₽ • ${linkedAcc?.name ?? "нет привязки"}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => _EditExpenseCategoryDialog(
                existing: category,
                accumulationCategories: accumulations,
                onSave: (c) => context.read<FinanceCubit>().saveExpenseCategory(c),
                onDelete: () => context.read<FinanceCubit>().deleteExpenseCategory(category.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AccumulationCategoryTile extends StatelessWidget {
  final AccumulationCategory category;
  const _AccumulationCategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = Color(category.colorValue);
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.savings_outlined, color: color),
        ),
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Базовый баланс: ${category.currentBalance.toStringAsFixed(0)} ₽',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => _EditAccumulationCategoryDialog(
                existing: category,
                onSave: (c) => context.read<FinanceCubit>().saveAccumulationCategory(c),
                onDelete: () => context.read<FinanceCubit>().deleteAccumulationCategory(category.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EditExpenseCategoryDialog extends StatefulWidget {
  final ExpenseCategory? existing;
  final List<AccumulationCategory> accumulationCategories;
  final Function(ExpenseCategory) onSave;
  final VoidCallback? onDelete;

  const _EditExpenseCategoryDialog({
    this.existing,
    required this.accumulationCategories,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<_EditExpenseCategoryDialog> createState() => _EditExpenseCategoryDialogState();
}

class _EditExpenseCategoryDialogState extends State<_EditExpenseCategoryDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _limitCtrl;
  String? _selectedAccumulationId;
  late int _selectedColorValue;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name);
    _limitCtrl = TextEditingController(text: widget.existing?.limit.toString() ?? '0');
    _selectedAccumulationId = widget.existing?.linkedAccumulationId;
    _selectedColorValue = widget.existing?.colorValue ?? Colors.blue.value;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _limitCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    final category = ExpenseCategory(
      id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      limit: double.tryParse(_limitCtrl.text) ?? 0,
      linkedAccumulationId: _selectedAccumulationId,
      colorValue: _selectedColorValue,
    );
    widget.onSave(category);
    Navigator.pop(context);
  }

  void _showAccumulationInfo() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Как работает привязка'),
        content: const Text(
          'Если выбрать накопление, то все деньги, которые останутся после фактических трат по этой категории, '
          'будут автоматически уходить в указанное накопление.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Понятно'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Добавить категорию' : 'Редактировать категорию'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Название', border: OutlineInputBorder()),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _limitCtrl,
              decoration: const InputDecoration(labelText: 'Недельный лимит (₽)', border: OutlineInputBorder()),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: _selectedAccumulationId,
              decoration: const InputDecoration(labelText: 'Привязать к накоплению', border: OutlineInputBorder()),
              items: [
                const DropdownMenuItem(value: null, child: Text('Не выбран')),
                ...widget.accumulationCategories.map(
                  (a) => DropdownMenuItem(value: a.id, child: Text(a.name)),
                ),
              ],
              onChanged: (v) => setState(() => _selectedAccumulationId = v),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Если выбрать накопление, остаток после трат по этой категории будет уходить туда.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Как работает привязка',
                  onPressed: _showAccumulationInfo,
                  icon: const Icon(Icons.help_outline, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Выберите цвет:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ColorPicker(
              selectedColor: _selectedColorValue,
              onColorSelected: (val) => setState(() => _selectedColorValue = val),
            ),
          ],
        ),
      ),
      actions: [
        if (widget.onDelete != null)
          TextButton(
            onPressed: () {
              widget.onDelete!();
              Navigator.pop(context);
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
        FilledButton(onPressed: _save, child: const Text('Сохранить')),
      ],
    );
  }
}

class _EditAccumulationCategoryDialog extends StatefulWidget {
  final AccumulationCategory? existing;
  final Function(AccumulationCategory) onSave;
  final VoidCallback? onDelete;

  const _EditAccumulationCategoryDialog({this.existing, required this.onSave, this.onDelete});

  @override
  State<_EditAccumulationCategoryDialog> createState() => _EditAccumulationCategoryDialogState();
}

class _EditAccumulationCategoryDialogState extends State<_EditAccumulationCategoryDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _balanceCtrl;
  late final TextEditingController _targetCtrl;
  late int _selectedColorValue;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existing?.name);
    _balanceCtrl = TextEditingController(text: widget.existing?.currentBalance.toString() ?? '0');
    _targetCtrl = TextEditingController(text: widget.existing?.targetAmount.toString() ?? '0');
    _selectedColorValue = widget.existing?.colorValue ?? Colors.green.value;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balanceCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    final category = AccumulationCategory(
      id: widget.existing?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      currentBalance: double.tryParse(_balanceCtrl.text) ?? 0,
      targetAmount: double.tryParse(_targetCtrl.text) ?? 0,
      colorValue: _selectedColorValue,
    );
    widget.onSave(category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Добавить накопление' : 'Редактировать накопление'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Название', border: OutlineInputBorder()),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _balanceCtrl,
              decoration: const InputDecoration(labelText: 'Текущий баланс (₽)', border: OutlineInputBorder()),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _targetCtrl,
              decoration: const InputDecoration(labelText: 'Целевая сумма (₽)', hintText: '0 - без цели', border: OutlineInputBorder()),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 16),
            const Text('Выберите цвет:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ColorPicker(
              selectedColor: _selectedColorValue,
              onColorSelected: (val) => setState(() => _selectedColorValue = val),
            ),
          ],
        ),
      ),
      actions: [
        if (widget.onDelete != null)
          TextButton(
            onPressed: () {
              widget.onDelete!();
              Navigator.pop(context);
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
        FilledButton(onPressed: _save, child: const Text('Сохранить')),
      ],
    );
  }
}
