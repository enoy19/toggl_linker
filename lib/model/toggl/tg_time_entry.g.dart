// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tg_time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglTimeEntry _$TogglTimeEntryFromJson(Map<String, dynamic> json) {
  return TogglTimeEntry(
    json['id'] as int,
    json['pid'] as int?,
    json['tid'] as int?,
    json['uid'] as int?,
    json['description'] as String,
    json['start'] as String,
    json['end'] as String,
    json['updated'] as String,
    json['dur'] as int,
    json['user'] as String,
    json['use_stop'] as bool,
    json['client'] as String?,
    json['project'] as String?,
    json['project_color'] as String?,
    json['project_hex_color'] as String?,
    (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TogglTimeEntryToJson(TogglTimeEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pid': instance.pid,
      'tid': instance.tid,
      'uid': instance.uid,
      'description': instance.description,
      'start': instance.start,
      'end': instance.end,
      'updated': instance.updated,
      'dur': instance.dur,
      'user': instance.user,
      'use_stop': instance.use_stop,
      'client': instance.client,
      'project': instance.project,
      'project_color': instance.project_color,
      'project_hex_color': instance.project_hex_color,
      'tags': instance.tags,
    };
