import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/api/redmine.dart';
import 'package:toggl_linker/api/toggl.dart';
import 'package:toggl_linker/cubit/configs_cubit.dart';
import 'package:toggl_linker/exception/configs_not_set_exception.dart';
import 'package:toggl_linker/model/configs.dart';
import 'package:toggl_linker/model/detailed_report.dart';
import 'package:toggl_linker/model/tg_time_entry.dart';

part 'toggl_redmine_state.dart';

class TogglRedmineCubit extends Cubit<TogglRedmineState> {
  TogglRedmineCubit() : super(TogglRedmineInitial());

  DateTimeRange? _prevDateTimeRange;
  late final ConfigsCubit _configsCubit;

  void init(BuildContext context) {
    _configsCubit = context.read<ConfigsCubit>();
  }

  DateTimeRange? get range => _prevDateTimeRange;

  Configs get _configs {
    if (_configsCubit.state is ConfigsSet) {
      return (_configsCubit.state as ConfigsSet).configs;
    }

    throw ConfigsNotSetException();
  }

  Toggl get _toggl {
    return Toggl(
      username: _configs.togglUsername,
      apiToken: _configs.togglApiKey,
      workspaceId: _configs.togglWorkspaceId,
      clientIds: _configs.togglClientIds,
    );
  }

  Redmine get _redmine {
    return Redmine(
      baseUrl: _configs.redmineBaseUrl,
      apiToken: _configs.redmineApiKey,
    );
  }

  void loadTogglEntries(DateTimeRange range) async {
    _prevDateTimeRange = range;
    emit(TogglRedmineInitial());
    try {
      final report = await _toggl.getReport(range);
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
        await _redmine.createTimeEntry(timeEntry);
      }

      await _toggl.markAsBooked(timeEntries);
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
