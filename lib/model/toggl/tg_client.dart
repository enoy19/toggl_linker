import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tg_client.g.dart';

@JsonSerializable()
class TogglClient extends Equatable {
  final int id;
  final int wid;
  final String name;

  TogglClient(this.id, this.wid, this.name);
  factory TogglClient.fromJson(Map<String, dynamic> json) =>
      _$TogglClientFromJson(json);

  Map<String, dynamic> toJson() => _$TogglClientToJson(this);

  @override
  List<Object?> get props => [id];
}
