import 'package:edulab_b2b/features/home/data/datasources/models/quiz_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

/// Body of `PUT /mobile/profile/`.
///
/// Both fields are always sent: the backend replaces what it receives, so
/// omitting one would wipe it. `profilePhoto` carries the [MediaDTO.src] of an
/// already-uploaded file (see `POST /media/upload/mobile/single`), or null to
/// clear the avatar.
@JsonSerializable(includeIfNull: true)
class ProfileUpdateRequest {
  @JsonKey(name: 'about_me')
  final String? aboutMe;
  @JsonKey(name: 'profile_photo')
  final String? profilePhoto;

  const ProfileUpdateRequest({required this.aboutMe, required this.profilePhoto});

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUpdateRequestToJson(this);
}

/// The updated profile the backend echoes back. It returns the full account
/// object; only the fields the app actually reads are modelled here.
@JsonSerializable(includeIfNull: true)
class ProfileResponse {
  @JsonKey(name: 'about_me', defaultValue: '')
  final String aboutMe;
  @JsonKey(name: 'profile_photo')
  final MediaDTO? profilePhoto;

  const ProfileResponse({required this.aboutMe, required this.profilePhoto});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
