// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tg_detailed_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TogglDetailedReport _$TogglDetailedReportFromJson(Map<String, dynamic> json) {
  return TogglDetailedReport(
    json['total_count'] as int,
    json['per_page'] as int,
    json['total_grand'] as int?,
    (json['data'] as List<dynamic>)
        .map((e) => TogglTimeEntry.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TogglDetailedReportToJson(
        TogglDetailedReport instance) =>
    <String, dynamic>{
      'total_count': instance.total_count,
      'per_page': instance.per_page,
      'total_grand': instance.total_grand,
      'data': instance.data,
    };
