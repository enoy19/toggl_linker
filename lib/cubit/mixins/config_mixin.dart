import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggl_linker/model/configs.dart';

import '../configs_cubit.dart';

mixin ConfigMixin {
  late final ConfigsCubit configsCubit;

  void initConfigs(BuildContext context) {
    configsCubit = context.read<ConfigsCubit>();
  }

  Configs get configs => configsCubit.configs;
  bool get isConfigured => configsCubit.isConfigured;
}
