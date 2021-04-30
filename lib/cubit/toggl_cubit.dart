import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/cubit/mixins/config_mixin.dart';
import 'package:toggl_linker/cubit/toggl_api_user%20copy.dart';
import 'package:toggl_linker/model/toggl/tg_workspace.dart';

part 'toggl_state.dart';

class TogglCubit extends Cubit<TogglState> with TogglApiUser, ConfigMixin {
  TogglCubit() : super(TogglInitial());

  void loadTogglData() async {
    if (isConfigured) {
      emit(TogglDataLoading());
      final workspaces = await toggl.getWorkspaces();
      emit(TogglData(workspaces));
    } else {
      emit(TogglDataLoadingFailed());
    }
  }
}
