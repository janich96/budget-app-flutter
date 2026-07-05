import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/week_entry.dart';

part 'week_entry_model.freezed.dart';
part 'week_entry_model.g.dart';

@freezed
abstract class WeekEntryModel with _$WeekEntryModel {
  const WeekEntryModel._();

  const factory WeekEntryModel({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    @Default({}) Map<String, double> expenses,
    @Default({}) Map<String, double> limitsSnapshot,
    @Default({}) Map<String, String> linksSnapshot,
  }) = _WeekEntryModel;

  factory WeekEntryModel.fromJson(Map<String, dynamic> json) => 
      _$WeekEntryModelFromJson(json);

  factory WeekEntryModel.fromEntity(WeekEntry entity) {
    return WeekEntryModel(
      id: entity.id,
      startDate: entity.startDate,
      endDate: entity.endDate,
      expenses: entity.expenses,
      limitsSnapshot: entity.limitsSnapshot,
      linksSnapshot: entity.linksSnapshot,
    );
  }

  WeekEntry toEntity() {
    return WeekEntry(
      id: id,
      startDate: startDate,
      endDate: endDate,
      expenses: expenses,
      limitsSnapshot: limitsSnapshot,
      linksSnapshot: linksSnapshot,
    );
  }
}
