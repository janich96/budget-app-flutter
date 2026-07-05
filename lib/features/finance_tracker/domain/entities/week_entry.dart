import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_entry.freezed.dart';
part 'week_entry.g.dart';

/// Фактические траты за неделю
@freezed
abstract class WeekEntry with _$WeekEntry {
  const factory WeekEntry({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    
    /// Мапа: (ID ExpenseCategory) -> Сумма фактических трат
    @Default({}) Map<String, double> expenses,
    
    /// Снимок лимитов на эту неделю: (ID ExpenseCategory) -> Сумма лимита, 
    /// чтобы логика не ломалась при изменении лимитов в будущем
    @Default({}) Map<String, double> limitsSnapshot,

    /// Снимок привязок к накоплениям: (ID ExpenseCategory) -> ID AccumulationCategory
    @Default({}) Map<String, String> linksSnapshot,
  }) = _WeekEntry;

  factory WeekEntry.fromJson(Map<String, dynamic> json) => _$WeekEntryFromJson(json);
}
