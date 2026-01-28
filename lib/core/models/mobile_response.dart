import 'package:json_annotation/json_annotation.dart';

part 'mobile_response.g.dart';

//Mobile Response to receive true or false for result
@JsonSerializable(includeIfNull: true)
class MobileResponse {
  @JsonKey(name: 'deleted')
  final bool isSuccess;

  MobileResponse({required this.isSuccess});

  factory MobileResponse.fromJson(Map<String, dynamic> json) =>
      _$MobileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MobileResponseToJson(this);
}
