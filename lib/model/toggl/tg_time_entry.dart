import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tg_time_entry.g.dart';

final _descriptionRegex = RegExp(r'^.*#(\d+).+\|(.*)$');

@JsonSerializable()
class TogglTimeEntry {
  final int id;
  final int? pid;
  final int? tid;
  final int? uid;
  final String description;
  final String start;
  final String end;
  final String updated;
  final int dur;
  final String user;
  final bool use_stop;
  final String? client;
  final String? project;
  final String? project_color;
  final String? project_hex_color;
  // final String task;
  // final String billable;
  // final String is_billable;
  // final String cur;
  final List<String> tags;

  TogglTimeEntry(
    this.id,
    this.pid,
    this.tid,
    this.uid,
    this.description,
    this.start,
    this.end,
    this.updated,
    this.dur,
    this.user,
    this.use_stop,
    this.client,
    this.project,
    this.project_color,
    this.project_hex_color,
    this.tags,
  );

  String? get redmineTicketId {
    final match = _descriptionRegex.firstMatch(description);
    return match?.group(1);
  }

  String? get comment {
    final match = _descriptionRegex.firstMatch(description);
    return match?.group(2)?.trim();
  }

  DateTime get startDate => DateTime.parse(start);
  DateTime get endDate => DateTime.parse(end);
  DateTimeRange get range => DateTimeRange(start: startDate, end: endDate);
  Duration get duration => range.duration;

  factory TogglTimeEntry.fromJson(Map<String, dynamic> json) =>
      _$TogglTimeEntryFromJson(json);
  Map<String, dynamic> toJson() => _$TogglTimeEntryToJson(this);
}
