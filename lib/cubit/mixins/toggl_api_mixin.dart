import 'package:toggl_linker/api/toggl.dart';
import 'package:toggl_linker/model/configs.dart';

mixin TogglApiMixin {
  Configs get configs;
  int? get currentWorkspace;
  List<int> get clientIds;

  Toggl get toggl {
    return Toggl(
      username: configs.togglUsername,
      apiToken: configs.togglApiKey,
      workspaceId: currentWorkspace,
      clientIds: clientIds,
    );
  }
}
