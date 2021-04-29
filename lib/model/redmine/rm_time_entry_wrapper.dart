import 'package:json_annotation/json_annotation.dart';
import 'package:toggl_linker/model/redmine/rm_time_entry.dart';

part 'rm_time_entry_wrapper.g.dart';

@JsonSerializable()
class RedmineTimeEntryWrapper {
  final RedmineTimeEntry time_entry;

  RedmineTimeEntryWrapper(this.time_entry);
  factory RedmineTimeEntryWrapper.fromJson(Map<String, dynamic> json) =>
      _$RedmineTimeEntryWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$RedmineTimeEntryWrapperToJson(this);
}
