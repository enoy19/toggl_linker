import 'package:json_annotation/json_annotation.dart';

part 'rm_time_entry.g.dart';

@JsonSerializable()
class RedmineTimeEntry {
  final String issue_id;
  final String spent_on;
  final double hours;
  final int activity_id;
  final String comments;

  RedmineTimeEntry(this.issue_id, this.spent_on, this.hours, this.activity_id,
      this.comments);

  factory RedmineTimeEntry.fromJson(Map<String, dynamic> json) =>
      _$RedmineTimeEntryFromJson(json);

  Map<String, dynamic> toJson() => _$RedmineTimeEntryToJson(this);
}
