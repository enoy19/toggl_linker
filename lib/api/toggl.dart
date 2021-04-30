import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toggl_linker/model/toggl/tg_detailed_report.dart';
import 'package:toggl_linker/model/toggl/tg_time_entry.dart';
import 'package:toggl_linker/model/toggl/tg_time_entry_bulk_update.dart';
import 'package:toggl_linker/model/toggl/tg_time_entry_bulk_update_wrapper.dart';

const bookedTag = '_BOOKED'; // TODO: create _BOOKED tag automatically in toggl
const _reportsBaseUrl = 'https://api.track.toggl.com/reports/api/v2';
const _togglBaseUrl = 'https://api.track.toggl.com/api/v8';
final _formatter = DateFormat('yyyy-MM-dd');

class Toggl {
  final String apiToken;
  final String username;
  final String workspaceId;
  final String clientIds;
  final String userAgent =
      'enoy19+toggl@gmail.com'; // app developer email address (https://github.com/toggl/toggl_api_docs/blob/master/reports.md#request-parameters)

  Toggl({
    required this.username,
    required this.apiToken,
    required this.workspaceId,
    required this.clientIds,
  });

  Future<DetailedReport> getReport(DateTimeRange range) async {
    final initialReport = await _getReportPage(range);

    int currentPage = 1;
    int currentEntries = initialReport.data.length;
    while (currentEntries < initialReport.total_count) {
      await Future.delayed(Duration(seconds: 1));
      currentPage++;
      final nextReport = await _getReportPage(range, page: currentPage);
      currentEntries += nextReport.data.length;
      initialReport.data.addAll(nextReport.data);
    }

    return initialReport;
  }

  Future<void> markAsBooked(List<TogglTimeEntry> timeEntries) async {
    final bulkUpdate = TogglTimeEntryBulkUpdate([bookedTag], 'add');
    final timeEntryIds = timeEntries.map((e) => e.id).join(',');
    final response = await http.put(
      Uri.parse('$_togglBaseUrl/time_entries/$timeEntryIds'),
      headers: _headers,
      body: jsonEncode(
        ToggleTimeEntryBulkUpdateWrapper(bulkUpdate).toJson(),
      ),
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('markAsBooked failed');
    }
  }

  Future<DetailedReport> _getReportPage(
    DateTimeRange range, {
    int page = 1,
  }) async {
    final response = await http.get(
      _pathReport('/details', queryParams: {
        'since': _formatter.format(range.start),
        'until': _formatter.format(range.end),
        'page': '$page'
      }),
      headers: _headers,
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('get reports failed');
    }

    return DetailedReport.fromJson(jsonDecode(response.body));
  }

  /// convenience method to create reports API Url
  Uri _pathReport(String path, {Map<String, String>? queryParams}) {
    List<String> queryItems = [];
    if (queryParams != null) {
      queryParams.forEach((key, value) => queryItems
          .add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(value)}'));
    }

    String query = queryItems.isEmpty ? '' : '&${queryItems.join('&')}';
    return Uri.parse(
      '$_reportsBaseUrl/$path?user_agent=$userAgent&workspace_id=$workspaceId&client_ids=$clientIds' +
          query,
    );
  }

  String get _auth =>
      "Basic ${base64Encode(utf8.encode("$apiToken:api_token"))}";

  Map<String, String> get _headers => {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': _auth,
      };
}
