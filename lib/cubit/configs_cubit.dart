import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/exception/configs_not_set_exception.dart';
import 'package:toggl_linker/model/configs.dart';

part 'configs_state.dart';

class ConfigsCubit extends HydratedCubit<ConfigsState> {
  ConfigsCubit() : super(ConfigsNone());

  void configure(Configs configs) {
    emit(ConfigsSet(configs));
  }

  bool get isConfigured => state is ConfigsSet;
  Configs get configs => isConfigured ? (state as ConfigsSet).configs : throw ConfigsNotSetException();

  @override
  ConfigsState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey("isSet")) {
      return ConfigsSet(Configs.fromJson(json));
    }
  }

  @override
  Map<String, dynamic>? toJson(ConfigsState state) {
    if (state is ConfigsSet) {
      final json = state.configs.toJson();
      json["isSet"] = true;
      return json;
    }
  }
}
