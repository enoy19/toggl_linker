import 'package:json_annotation/json_annotation.dart';
import 'package:toggl_linker/api/toggl.dart';

import 'tg_time_entry.dart';

part 'detailed_report.g.dart';

@JsonSerializable()
class DetailedReport {
  final int total_count;
  final int per_page;
  final int? total_grand;
  final List<TogglTimeEntry> data;

  DetailedReport(this.total_count, this.per_page, this.total_grand, this.data);

  List<TogglTimeEntry> getNotBookedTimeEntries() {
    return data.where((element) => !element.tags.contains(bookedTag)).toList();
  }

  factory DetailedReport.fromJson(Map<String, dynamic> json) =>
      _$DetailedReportFromJson(json);
  Map<String, dynamic> toJson() => _$DetailedReportToJson(this);
}
