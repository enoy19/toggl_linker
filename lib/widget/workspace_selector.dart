import 'package:flutter/material.dart';
import 'package:toggl_linker/model/toggl/tg_workspace.dart';

class WorkspaceSelector extends StatefulWidget {
  final List<TogglWorkspace> workspaces;
  final TogglWorkspace? initialValue;
  final Function(TogglWorkspace?) onChanged;

  const WorkspaceSelector({
    Key? key,
    required this.workspaces,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _WorkspaceSelectorState createState() => _WorkspaceSelectorState();
}

class _WorkspaceSelectorState extends State<WorkspaceSelector> {
  TogglWorkspace? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TogglWorkspace>(
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
        widget.onChanged(value);
      },
      value: value,
      items: widget.workspaces.map(
        (workspace) {
          return DropdownMenuItem<TogglWorkspace>(
            child: Text(workspace.name),
            value: workspace,
          );
        },
      ).toList(),
    );
  }
}
