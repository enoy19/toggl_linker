import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toggl_linker/cubit/clients_cubit.dart';
import 'package:toggl_linker/cubit/configs_cubit.dart';
import 'package:toggl_linker/cubit/toggl_redmine_cubit.dart';
import 'package:toggl_linker/cubit/workspace_cubit.dart';

import 'booking.dart';
import 'cubit/toggl_cubit.dart';
import 'util/date_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDir = await getApplicationDocumentsDirectory();
  final appDir = Directory('${documentsDir.path}/toggl_linker');
  print('appDir: $appDir');

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: appDir,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => ConfigsCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CurrentWorkspaceCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => ClientsCubit(),
        ),
        BlocProvider(
          create: (context) => TogglCubit()..initConfigs(context)
        ),
        BlocProvider(
          create: (context) => TogglRedmineCubit()
            ..initConfigs(context)
            ..loadTogglEntries(DateUtil.lastWeekRange()),
        ),
      ],
      child: MaterialApp(
        title: 'Toggl Redmine Booking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Booking(),
      ),
    );
  }
}
