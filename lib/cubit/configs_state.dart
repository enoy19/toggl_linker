part of 'configs_cubit.dart';

@immutable
abstract class ConfigsState {}

class ConfigsNone extends ConfigsState {}

class ConfigsSet extends ConfigsState {
  final Configs configs;

  ConfigsSet(this.configs);
}
