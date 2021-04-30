import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggl_linker/cubit/clients_cubit.dart';
import 'package:toggl_linker/cubit/workspace_cubit.dart';
import 'package:toggl_linker/model/configs.dart';

import '../configs_cubit.dart';

mixin ConfigMixin {
  late final ConfigsCubit configsCubit;
  late final CurrentWorkspaceCubit currentWorkspaceCubit;
  late final ClientsCubit clientsCubit;

  void initConfigs(BuildContext context) {
    configsCubit = context.read<ConfigsCubit>();
    currentWorkspaceCubit = context.read<CurrentWorkspaceCubit>();
    clientsCubit = context.read<ClientsCubit>();
  }

  Configs get configs => configsCubit.configs;
  bool get isConfigured => configsCubit.isConfigured;
  int? get currentWorkspace => currentWorkspaceCubit.state;
  List<int> get clientIds => clientsCubit.state;
}
