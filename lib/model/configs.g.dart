// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configs _$ConfigsFromJson(Map<String, dynamic> json) {
  return Configs(
    redmineApiKey: json['redmineApiKey'] as String,
    redmineBaseUrl: json['redmineBaseUrl'] as String,
    togglUsername: json['togglUsername'] as String,
    togglApiKey: json['togglApiKey'] as String,
    togglWorkspaceId: json['togglWorkspaceId'] as String,
    togglClientIds: json['togglClientIds'] as String,
  );
}

Map<String, dynamic> _$ConfigsToJson(Configs instance) => <String, dynamic>{
      'redmineApiKey': instance.redmineApiKey,
      'redmineBaseUrl': instance.redmineBaseUrl,
      'togglUsername': instance.togglUsername,
      'togglApiKey': instance.togglApiKey,
      'togglWorkspaceId': instance.togglWorkspaceId,
      'togglClientIds': instance.togglClientIds,
    };
