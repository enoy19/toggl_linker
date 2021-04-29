part of 'toggl_redmine_cubit.dart';

@immutable
abstract class TogglRedmineState {}

class TogglRedmineInitial extends TogglRedmineState {}

class TogglReportLoaded extends TogglRedmineState {
  final DetailedReport detailedReport;

  TogglReportLoaded(this.detailedReport);
}

class TogglRedmineFailed<T> extends TogglRedmineState {
  final T error;

  TogglRedmineFailed(this.error);
}

class TogglRedmineBooking extends TogglRedmineState {}
