import 'package:toggl_linker/api/redmine.dart';
import 'package:toggl_linker/model/configs.dart';

mixin RedmineApiMixin {
  Configs get configs;

  Redmine get redmine {
    return Redmine(
      baseUrl: configs.redmineBaseUrl,
      apiToken: configs.redmineApiKey,
    );
  }
}
