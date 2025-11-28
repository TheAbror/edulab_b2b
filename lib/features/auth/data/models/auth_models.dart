import 'package:json_annotation/json_annotation.dart';
import 'package:leti_mobile/features/home/data/datasources/models/courses_models.dart';

part 'auth_models.g.dart';

@JsonSerializable(includeIfNull: true)
class AuthResponse {
  @JsonKey(defaultValue: '')
  final String token;
  @JsonKey(name: 'user_info')
  final UserInfo userInfo;

  AuthResponse({required this.token, required this.userInfo});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class SignUpRequest {
  @JsonKey(defaultValue: '')
  final String firstname;
  @JsonKey(defaultValue: '')
  final String lastname;
  @JsonKey(defaultValue: '')
  final String midname;
  @JsonKey(defaultValue: '')
  final String email;
  @JsonKey(defaultValue: '')
  final String password;
  @JsonKey(defaultValue: '')
  final String phone;
  @JsonKey(defaultValue: '', name: 'verification_code')
  final String verificationCode;
  final LocaleLanguageType localeLanguageType;

  SignUpRequest({
    required this.firstname,
    required this.lastname,
    required this.midname,
    required this.email,
    required this.password,
    required this.phone,
    required this.verificationCode,
    required this.localeLanguageType,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class LocaleLanguageType {
  @JsonKey(defaultValue: '')
  final String label;
  @JsonKey(defaultValue: '')
  final String value;

  LocaleLanguageType({required this.label, required this.value});

  factory LocaleLanguageType.fromJson(Map<String, dynamic> json) =>
      _$LocaleLanguageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleLanguageTypeToJson(this);
}

@JsonSerializable(includeIfNull: true)
class UserInfo {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String username;
  @JsonKey(defaultValue: '')
  final String firstname;
  @JsonKey(defaultValue: '')
  final String lastname;
  @JsonKey(name: 'profile_photo')
  final MediaDTO profilePhoto;
  @JsonKey(defaultValue: [])
  final List<String> roles;
  // final String roles_map: HashMap<String, String>? = null
  @JsonKey(defaultValue: [], name: 'required_actions')
  final List<UserRequiredActions> requiredActions;
  @JsonKey(defaultValue: '')
  final String email;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(defaultValue: '', name: 'account_type')
  final String accountType;
  @JsonKey(defaultValue: '', name: 'account_type_str')
  final String accountTypeStr;

  UserInfo({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.profilePhoto,
    required this.roles,
    required this.requiredActions,
    required this.email,
    required this.status,
    required this.accountType,
    required this.accountTypeStr,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable(includeIfNull: true)
class UserRequiredActions {
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(defaultValue: '', name: 'account_type')
  final String accountType;

  UserRequiredActions({required this.status, required this.accountType});

  factory UserRequiredActions.fromJson(Map<String, dynamic> json) =>
      _$UserRequiredActionsFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequiredActionsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class SignInRequest {
  @JsonKey(defaultValue: '')
  final String username;
  @JsonKey(defaultValue: '')
  final String password;

  SignInRequest({required this.username, required this.password});

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class SignUpKeyRequest {
  @JsonKey(defaultValue: '')
  final String recipient;
  @JsonKey(defaultValue: '')
  final String type;

  SignUpKeyRequest({required this.type, required this.recipient});

  factory SignUpKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpKeyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpKeyRequestToJson(this);
}

// Forgot password reset request
@JsonSerializable(includeIfNull: true)
class GetVerificationCodeBySendingLogin {
  // GET VERIFICATION  CODE BY SENDING LOGIN
  @JsonKey(defaultValue: '', name: 'signin_key')
  final String signInKey;
  @JsonKey(defaultValue: '')
  final String type;

  GetVerificationCodeBySendingLogin({
    required this.signInKey,
    required this.type,
  });

  factory GetVerificationCodeBySendingLogin.fromJson(
    Map<String, dynamic> json,
  ) => _$GetVerificationCodeBySendingLoginFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetVerificationCodeBySendingLoginToJson(this);
}

@JsonSerializable(includeIfNull: true)
class ResetPasswordToNew {
  //RESET PASSWORD
  @JsonKey(defaultValue: '', name: 'new_password')
  final String newPassword;

  ResetPasswordToNew({required this.newPassword});

  factory ResetPasswordToNew.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordToNewFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordToNewToJson(this);
}
