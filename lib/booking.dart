import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toggl_linker/config_view.dart';
import 'package:toggl_linker/cubit/clients_cubit.dart';
import 'package:toggl_linker/cubit/configs_cubit.dart';
import 'package:toggl_linker/cubit/toggl_cubit.dart';
import 'package:toggl_linker/cubit/toggl_redmine_cubit.dart';
import 'package:toggl_linker/exception/configs_not_set_exception.dart';
import 'package:toggl_linker/model/toggl/tg_client.dart';
import 'package:toggl_linker/model/toggl/tg_time_entry.dart';
import 'package:toggl_linker/model/toggl/tg_workspace.dart';
import 'package:toggl_linker/util/extension/hex_color.dart';
import 'package:toggl_linker/widget/workspace_selector.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/workspace_cubit.dart';

final _formatter = DateFormat('dd-MM-yyyy');

class Booking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggl Redmine Booking'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _configure(context),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<TogglRedmineCubit>().reload(),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<TogglRedmineCubit, TogglRedmineState>(
        builder: (context, state) {
          if (state is TogglReportLoaded &&
              state.detailedReport.getNotBookedTimeEntries().isNotEmpty) {
            return FloatingActionButton(
              onPressed: () async {
                final cubit = context.read<TogglRedmineCubit>();
                final state = cubit.state;
                if (state is TogglReportLoaded) {
                  final timeEntries =
                      state.detailedReport.getNotBookedTimeEntries();

                  final confirm = await _confirm(context,
                      'Do you want to book ${timeEntries.length} time ${timeEntries.length > 1 ? 'entries' : 'entry'}');

                  if (confirm) {
                    final success = await cubit.book(timeEntries);
                    if (success) cubit.reload();
                  }
                }
              },
              child: Icon(Icons.book),
            );
          }

          return Container();
        },
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => _selectTimeRange(context),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  final currentRange = context.watch<TogglRedmineCubit>().range;

                  if (currentRange != null) {
                    return Text(
                        '${_formatter.format(currentRange.start)} - ${_formatter.format(currentRange.end)}');
                  }

                  return Text('Select Time Range');
                },
              ),
            ),
          ),
          BlocBuilder<TogglCubit, TogglState>(
            builder: (context, state) {
              if (state is TogglData) {
                final workspaces = state.workspaces;

                final currentWorkspaceId =
                    context.watch<CurrentWorkspaceCubit>().state;

                final initialWorkspace =
                    workspaces.map((e) => e as TogglWorkspace?).firstWhere(
                          (element) => element?.id == currentWorkspaceId,
                          orElse: () => null,
                        );

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WorkspaceSelector(
                      workspaces: workspaces,
                      initialValue: initialWorkspace,
                      onChanged: (value) {
                        context.read<CurrentWorkspaceCubit>().emit(value?.id);
                        context.read<ClientsCubit>().emit([]);
                        context.read<TogglRedmineCubit>().reload();
                      },
                    ),
                    BlocBuilder<CurrentWorkspaceCubit, int?>(
                        builder: (context, currentWorkspaceId) {
                      if (currentWorkspaceId != null) {
                        final clientIds = context.watch<ClientsCubit>().state;

                        final clients = state.clients
                            .where(
                                (element) => element.wid == currentWorkspaceId)
                            .toList();

                        if (clients.isEmpty) {
                          return Container();
                        }

                        final initialClients = clientIds
                            .map((e) => clients
                                .firstWhere((element) => element.id == e))
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MultiSelectChipField<TogglClient?>(
                            key: GlobalKey(),
                            decoration: BoxDecoration(),
                            showHeader: false,
                            scroll: true,
                            scrollBar: HorizontalScrollBar(),
                            initialValue: initialClients,
                            items: clients
                                .map((e) => MultiSelectItem(e, e.name))
                                .toList(),
                            onTap: (values) {
                              final clientIds = values
                                  .where((element) => element != null)
                                  .map((e) => e!)
                                  .map((e) => e.id)
                                  .toList();
                              context.read<ClientsCubit>().emit(clientIds);
                              context.read<TogglRedmineCubit>().reload();
                            },
                          ),
                        );
                      }

                      return Container();
                    }),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
          Expanded(
            child: BlocBuilder<TogglRedmineCubit, TogglRedmineState>(
              builder: (context, state) {
                if (state is TogglReportLoaded) {
                  final report = state.detailedReport;
                  final timeEntries = report.getNotBookedTimeEntries();

                  if (timeEntries.isEmpty) {
                    return Center(
                      child: Text('Everything is booked'),
                    );
                  }

                  return ListView.builder(
                    itemCount: timeEntries.length,
                    itemBuilder: (context, index) {
                      final entry = timeEntries[index];

                      return ListTile(
                        onTap: () async {
                          final confirm = await _confirm(
                            context,
                            '''Do you want to book 
${entry.redmineTicketId ?? '<NO ID>'} ${entry.comment ?? '<NO DESCRIPTION FOUND>'} (${entry.duration.inMinutes / 60}h)?''',
                          );

                          if (confirm == true) {
                            _bookSingle(context, entry);
                          }
                        },
                        onLongPress: () => _launchIssueUrl(context, entry),
                        title: Text(entry.comment ?? '<NO DESCRIPTION FOUND>'),
                        subtitle: Text('${entry.duration.inMinutes / 60}h'),
                        trailing: Text(
                          entry.project ?? '',
                          style: TextStyle(
                              color: HexColor.fromHex(
                                  entry.project_hex_color ?? '000000')),
                        ),
                        leading: Text(entry.redmineTicketId ?? '<NO ID>'),
                      );
                    },
                  );
                } else if (state is TogglRedmineFailed) {
                  final error = state.error;

                  if (error is ConfigsNotSetException) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () => _configure(context),
                        child: Text('CONFIGURE'),
                      ),
                    );
                  }

                  if (error is Error) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'an unexpected error happened: ${error.toString()}\n${error.stackTrace.toString()}',
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return Center(
                    child: Text(
                      error.toString(),
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectTimeRange(BuildContext context) async {
    final currentRange = context.read<TogglRedmineCubit>().range;

    final range = await showDateRangePicker(
      context: context,
      initialDateRange: currentRange,
      firstDate: DateTime.now().subtract(
        Duration(days: 999),
      ),
      lastDate: DateTime.now(),
    );

    if (range != null) {
      context.read<TogglRedmineCubit>().loadTogglEntries(range);
    }
  }

  void _configure(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ConfigView();
      }),
    );

    context.read<TogglRedmineCubit>().reload();
  }

  void _launchIssueUrl(BuildContext context, TogglTimeEntry entry) async {
    final state = context.read<ConfigsCubit>().state;
    if (state is ConfigsSet) {
      final configs = state.configs;

      final issueUrl =
          '${configs.redmineBaseUrl}/issues/${entry.redmineTicketId}';
      if (await canLaunch(issueUrl)) {
        launch(issueUrl);
      }
    }
  }

  void _bookSingle(BuildContext context, TogglTimeEntry entry) async {
    final cubit = context.read<TogglRedmineCubit>();
    final success = await cubit.book([entry]);
    if (success) cubit.reload();
  }

  Future<bool> _confirm(BuildContext context, String text) async {
    final confirm = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('NO'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('YES'),
              ),
            ],
          );
        });

    return confirm == true;
  }
}
