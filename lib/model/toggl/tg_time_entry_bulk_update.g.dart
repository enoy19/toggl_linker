// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tg_time_entry_bulk_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglTimeEntryBulkUpdate _$TogglTimeEntryBulkUpdateFromJson(
    Map<String, dynamic> json) {
  return TogglTimeEntryBulkUpdate(
    (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    json['tag_action'] as String,
  );
}

Map<String, dynamic> _$TogglTimeEntryBulkUpdateToJson(
        TogglTimeEntryBulkUpdate instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'tag_action': instance.tag_action,
    };
