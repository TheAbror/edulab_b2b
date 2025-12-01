import 'package:json_annotation/json_annotation.dart';

part 'mobile_response.g.dart';

//Mobile Response to receive true or false for result
@JsonSerializable(includeIfNull: true)
class MobileResponse {
  final bool deleted;

  MobileResponse({required this.deleted});

  factory MobileResponse.fromJson(Map<String, dynamic> json) =>
      _$MobileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MobileResponseToJson(this);
}
