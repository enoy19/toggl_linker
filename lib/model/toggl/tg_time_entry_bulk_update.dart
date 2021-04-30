import 'package:json_annotation/json_annotation.dart';

part 'tg_time_entry_bulk_update.g.dart';

@JsonSerializable()
class TogglTimeEntryBulkUpdate {
  final List<String> tags;
  final String tag_action;

  TogglTimeEntryBulkUpdate(this.tags, this.tag_action);
  factory TogglTimeEntryBulkUpdate.fromJson(Map<String, dynamic> json) =>
      _$TogglTimeEntryBulkUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$TogglTimeEntryBulkUpdateToJson(this);
}
