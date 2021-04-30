import 'package:json_annotation/json_annotation.dart';
import 'package:toggl_linker/api/toggl.dart';

import 'tg_time_entry.dart';

part 'tg_detailed_report.g.dart';

@JsonSerializable()
class TogglDetailedReport {
  final int total_count;
  final int per_page;
  final int? total_grand;
  final List<TogglTimeEntry> data;

  TogglDetailedReport(this.total_count, this.per_page, this.total_grand, this.data);

  List<TogglTimeEntry> getNotBookedTimeEntries() {
    return data.where((element) => !element.tags.contains(bookedTag)).toList();
  }

  factory TogglDetailedReport.fromJson(Map<String, dynamic> json) =>
      _$TogglDetailedReportFromJson(json);
  Map<String, dynamic> toJson() => _$TogglDetailedReportToJson(this);
}
