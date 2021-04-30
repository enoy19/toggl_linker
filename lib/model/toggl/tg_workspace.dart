import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tg_workspace.g.dart';

@JsonSerializable()
class TogglWorkspace extends Equatable {
  final int id;
  final String name;

  TogglWorkspace(this.id, this.name);

  factory TogglWorkspace.fromJson(Map<String, dynamic> json) =>
      _$TogglWorkspaceFromJson(json);

  Map<String, dynamic> toJson() => _$TogglWorkspaceToJson(this);

  @override
  List<Object?> get props => [id];
}
