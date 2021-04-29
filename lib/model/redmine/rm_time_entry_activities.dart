import 'package:json_annotation/json_annotation.dart';
import 'package:toggl_linker/model/redmine/rm_time_entry_activity.dart';

part 'rm_time_entry_activities.g.dart';

@JsonSerializable()
class RedmineTimeEntryActivities {
  final List<RedmineTimeEntryActivity> time_entry_activities;

  RedmineTimeEntryActivities(this.time_entry_activities);
  factory RedmineTimeEntryActivities.fromJson(Map<String, dynamic> json) =>
      _$RedmineTimeEntryActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$RedmineTimeEntryActivitiesToJson(this);
}
