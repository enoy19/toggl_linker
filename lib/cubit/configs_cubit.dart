import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/model/configs.dart';

part 'configs_state.dart';

class ConfigsCubit extends HydratedCubit<ConfigsState> {
  ConfigsCubit() : super(ConfigsNone());

  void configure(Configs configs) {
    emit(ConfigsSet(configs));
  }

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
