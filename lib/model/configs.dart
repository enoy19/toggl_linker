import 'package:json_annotation/json_annotation.dart';

part 'configs.g.dart';

@JsonSerializable()
class Configs {
  String redmineApiKey;
  String redmineBaseUrl;
  String togglUsername;
  String togglApiKey;

  Configs({
    required this.redmineApiKey,
    required this.redmineBaseUrl,
    required this.togglUsername,
    required this.togglApiKey
  });

  factory Configs.empty() => Configs(
        redmineApiKey: '',
        redmineBaseUrl: '',
        togglUsername: '',
        togglApiKey: '',
      );

  factory Configs.fromJson(Map<String, dynamic> json) =>
      _$ConfigsFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigsToJson(this);
}
