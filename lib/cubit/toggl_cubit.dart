import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:toggl_linker/cubit/mixins/config_mixin.dart';
import 'package:toggl_linker/cubit/mixins/toggl_api_mixin.dart';
import 'package:toggl_linker/model/toggl/tg_workspace.dart';

import 'configs_cubit.dart';

part 'toggl_state.dart';

class TogglCubit extends Cubit<TogglState> with TogglApiMixin, ConfigMixin {
  TogglCubit() : super(TogglInitial());

  StreamSubscription<ConfigsState>? _subscription;

  @override
  void initConfigs(BuildContext context) {
    super.initConfigs(context);

    _subscription?.cancel();
    _subscription = configsCubit.stream.listen((event) {
      if (isConfigured) {
        loadTogglData();
      }
    });

    if (isConfigured) {
      loadTogglData();
    }
  }

  void loadTogglData() async {
    if (isConfigured) {
      emit(TogglDataLoading());
      final workspaces = await toggl.getWorkspaces();
      emit(TogglData(workspaces));
    } else {
      emit(TogglDataLoadingFailed());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
