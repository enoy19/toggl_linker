// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_time_entry_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedmineTimeEntryWrapper _$RedmineTimeEntryWrapperFromJson(
    Map<String, dynamic> json) {
  return RedmineTimeEntryWrapper(
    RedmineTimeEntry.fromJson(json['time_entry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RedmineTimeEntryWrapperToJson(
        RedmineTimeEntryWrapper instance) =>
    <String, dynamic>{
      'time_entry': instance.time_entry,
    };
