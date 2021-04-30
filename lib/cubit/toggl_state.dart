part of 'toggl_cubit.dart';

@immutable
abstract class TogglState {}

class TogglInitial extends TogglState {}

class TogglDataLoading extends TogglState {}

class TogglDataLoadingFailed extends TogglState {}

class TogglData extends TogglState {
  final List<TogglWorkspace> workspaces;

  TogglData(this.workspaces);
}
