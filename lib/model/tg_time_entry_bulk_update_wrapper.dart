import 'package:json_annotation/json_annotation.dart';
import 'package:toggl_linker/model/tg_time_entry_bulk_update.dart';

part 'tg_time_entry_bulk_update_wrapper.g.dart';

@JsonSerializable()
class ToggleTimeEntryBulkUpdateWrapper {
  final TogglTimeEntryBulkUpdate time_entry;

  ToggleTimeEntryBulkUpdateWrapper(this.time_entry);
  factory ToggleTimeEntryBulkUpdateWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$ToggleTimeEntryBulkUpdateWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ToggleTimeEntryBulkUpdateWrapperToJson(this);
}
