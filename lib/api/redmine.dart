import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toggl_linker/exception/activity_not_found_exception.dart';
import 'package:toggl_linker/model/redmine/rm_time_entry.dart';
import 'package:toggl_linker/model/redmine/rm_time_entry_activities.dart';
import 'package:toggl_linker/model/redmine/rm_time_entry_wrapper.dart';
import 'package:toggl_linker/model/tg_time_entry.dart';
import 'package:toggl_linker/util/extension/duration_extension.dart';

final _formatter = DateFormat('yyyy-MM-dd');

class Redmine {
  final String baseUrl;
  final String apiToken;

  RedmineTimeEntryActivities? _activities;

  Redmine({
    required this.baseUrl,
    required this.apiToken,
  });

  Future<RedmineTimeEntryActivities> _getActivities() async {
    final response = await http.get(
      Uri.parse('$baseUrl/enumerations/time_entry_activities.json'),
      headers: {
        'Content-Type': 'application/json',
        'X-Redmine-API-Key': apiToken,
      },
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('getting activities failed');
    }

    return RedmineTimeEntryActivities.fromJson(jsonDecode(response.body));
  }

  Future<void> createTimeEntry(TogglTimeEntry togglTimeEntry) async {
    if (togglTimeEntry.tags.isEmpty) {
      throw Exception(
          'time entry does not have activity: ${togglTimeEntry.description}');
    }

    if (_activities == null) {
      _activities = await _getActivities();
    }

    final activityIds = togglTimeEntry.tags
        .map(_getActivityId)
        .where((element) => element != null)
        .map((e) => e!);

    final defaultActivityId = _getDefaultActivity();

    final activityId = activityIds.isNotEmpty
        ? activityIds.first
        : defaultActivityId != null
            ? defaultActivityId
            : throw ActivityNotFoundException(togglTimeEntry.tags);

    final minutes = togglTimeEntry.duration
        .roundUp(delta: Duration(minutes: 15))
        .inMinutes
        .toDouble();

    final redmineTimeEntry = RedmineTimeEntry(
      togglTimeEntry.redmineTicketId!,
      _formatter.format(togglTimeEntry.startDate),
      minutes / 60,
      activityId,
      togglTimeEntry.comment ?? '',
    );

    final response = await http.post(
      Uri.parse(
          '$baseUrl/time_entries.json?issue_id=${togglTimeEntry.redmineTicketId}'),
      headers: {
        'Content-Type': 'application/json',
        'X-Redmine-API-Key': apiToken,
      },
      body: jsonEncode(
        RedmineTimeEntryWrapper(redmineTimeEntry).toJson(),
      ),
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('createTimeEntry failed');
    }
  }

  int? _getActivityId(String activityName) {
    final activityIds = _activities!.time_entry_activities
        .where(
          (element) =>
              element.name.trim().toLowerCase() ==
              activityName.trim().toLowerCase(),
        )
        .map((e) => e.id);

    return activityIds.isEmpty ? null : activityIds.first;
  }

  int? _getDefaultActivity() {
    try {
      return _activities!.time_entry_activities
          .where((element) => element.is_default)
          .map((e) => e.id)
          .firstWhere((element) => true);
    } catch (e) {
      return null;
    }
  }
}
