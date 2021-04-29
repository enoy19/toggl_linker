import 'package:json_annotation/json_annotation.dart';

part 'rm_time_entry_activity.g.dart';

@JsonSerializable()
class RedmineTimeEntryActivity {
  final int id;
  final String name;
  final bool is_default;

  RedmineTimeEntryActivity(this.id, this.name, this.is_default);

  factory RedmineTimeEntryActivity.fromJson(Map<String, dynamic> json) =>
      _$RedmineTimeEntryActivityFromJson(json);

  Map<String, dynamic> toJson() => _$RedmineTimeEntryActivityToJson(this);
}
