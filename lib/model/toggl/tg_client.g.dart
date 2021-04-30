// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tg_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglClient _$TogglClientFromJson(Map<String, dynamic> json) {
  return TogglClient(
    json['id'] as int,
    json['wid'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$TogglClientToJson(TogglClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wid': instance.wid,
      'name': instance.name,
    };
