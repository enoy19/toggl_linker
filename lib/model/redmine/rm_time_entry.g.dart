// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedmineTimeEntry _$RedmineTimeEntryFromJson(Map<String, dynamic> json) {
  return RedmineTimeEntry(
    json['issue_id'] as String,
    json['spent_on'] as String,
    (json['hours'] as num).toDouble(),
    json['activity_id'] as int,
    json['comments'] as String,
  );
}

Map<String, dynamic> _$RedmineTimeEntryToJson(RedmineTimeEntry instance) =>
    <String, dynamic>{
      'issue_id': instance.issue_id,
      'spent_on': instance.spent_on,
      'hours': instance.hours,
      'activity_id': instance.activity_id,
      'comments': instance.comments,
    };
