import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/cubit/mixins/config_mixin.dart';
import 'package:toggl_linker/cubit/mixins/redmine_api_mixin.dart';
import 'package:toggl_linker/model/toggl/tg_detailed_report.dart';
import 'package:toggl_linker/model/toggl/tg_time_entry.dart';

import 'mixins/toggl_api_mixin.dart';

part 'toggl_redmine_state.dart';

class TogglRedmineCubit extends Cubit<TogglRedmineState> with TogglApiMixin, RedmineApiMixin, ConfigMixin {
  TogglRedmineCubit() : super(TogglRedmineInitial());

  DateTimeRange? _prevDateTimeRange;

  DateTimeRange? get range => _prevDateTimeRange;

  void loadTogglEntries(DateTimeRange range) async {
    _prevDateTimeRange = range;
    emit(TogglRedmineInitial());
    try {
      final report = await toggl.getReport(range);
      emit(TogglReportLoaded(report));
    } on Exception catch (e) {
      emit(TogglRedmineFailed<Exception>(e));
      return;
    } on Error catch (e) {
      emit(TogglRedmineFailed<Error>(e));
      return;
    }
  }

  Future<bool> book(List<TogglTimeEntry> timeEntries) async {
    emit(TogglRedmineBooking());

    try {
      for (final timeEntry in timeEntries) {
        await redmine.createTimeEntry(timeEntry);
      }

      await toggl.markAsBooked(timeEntries);
    } on Exception catch (e) {
      emit(TogglRedmineFailed(e));
      return false;
    } on Error catch (e) {
      emit(TogglRedmineFailed(e));
      return false;
    }

    return true;
  }

  void reload() {
    if (_prevDateTimeRange != null) {
      loadTogglEntries(_prevDateTimeRange!);
    }
  }
}
