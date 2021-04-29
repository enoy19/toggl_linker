import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toggl_linker/cubit/configs_cubit.dart';
import 'package:toggl_linker/cubit/toggl_redmine_cubit.dart';

import 'booking.dart';
import 'util/date_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
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
          create: (context) => TogglRedmineCubit()
            ..init(context)
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
