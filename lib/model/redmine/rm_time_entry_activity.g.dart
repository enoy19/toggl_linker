// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_time_entry_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedmineTimeEntryActivity _$RedmineTimeEntryActivityFromJson(
    Map<String, dynamic> json) {
  return RedmineTimeEntryActivity(
    json['id'] as int,
    json['name'] as String,
    json['is_default'] as bool,
  );
}

Map<String, dynamic> _$RedmineTimeEntryActivityToJson(
        RedmineTimeEntryActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_default': instance.is_default,
    };
