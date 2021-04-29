// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_time_entry_activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedmineTimeEntryActivities _$RedmineTimeEntryActivitiesFromJson(
    Map<String, dynamic> json) {
  return RedmineTimeEntryActivities(
    (json['time_entry_activities'] as List<dynamic>)
        .map(
            (e) => RedmineTimeEntryActivity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RedmineTimeEntryActivitiesToJson(
        RedmineTimeEntryActivities instance) =>
    <String, dynamic>{
      'time_entry_activities': instance.time_entry_activities,
    };
