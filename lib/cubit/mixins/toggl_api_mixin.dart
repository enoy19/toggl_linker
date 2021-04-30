import 'package:toggl_linker/api/toggl.dart';
import 'package:toggl_linker/model/configs.dart';

mixin TogglApiMixin {
  Configs get configs;

  Toggl get toggl {
    return Toggl(
      username: configs.togglUsername,
      apiToken: configs.togglApiKey,
      workspaceId: configs.togglWorkspaceId,
      clientIds: configs.togglClientIds,
    );
  }
}