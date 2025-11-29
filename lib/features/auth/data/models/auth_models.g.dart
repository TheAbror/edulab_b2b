// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  token: json['token'] as String? ?? '',
  userInfo: UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user_info': instance.userInfo};

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      midname: json['midname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      verificationCode: json['verification_code'] as String? ?? '',
      localeLanguageType: LocaleLanguageType.fromJson(
        json['localeLanguageType'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'midname': instance.midname,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'verification_code': instance.verificationCode,
      'localeLanguageType': instance.localeLanguageType,
    };

LocaleLanguageType _$LocaleLanguageTypeFromJson(Map<String, dynamic> json) =>
    LocaleLanguageType(
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$LocaleLanguageTypeToJson(LocaleLanguageType instance) =>
    <String, dynamic>{'label': instance.label, 'value': instance.value};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  id: (json['id'] as num?)?.toInt() ?? 0,
  username: json['username'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  lastname: json['lastname'] as String? ?? '',
  profilePhoto: MediaDTO.fromJson(
    json['profile_photo'] as Map<String, dynamic>,
  ),
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  requiredActions:
      (json['required_actions'] as List<dynamic>?)
          ?.map((e) => UserRequiredActions.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  email: json['email'] as String? ?? '',
  status: json['status'] as String? ?? '',
  accountType: json['account_type'] as String? ?? '',
  accountTypeStr: json['account_type_str'] as String? ?? '',
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'firstname': instance.firstname,
  'lastname': instance.lastname,
  'profile_photo': instance.profilePhoto,
  'roles': instance.roles,
  'required_actions': instance.requiredActions,
  'email': instance.email,
  'status': instance.status,
  'account_type': instance.accountType,
  'account_type_str': instance.accountTypeStr,
};

UserRequiredActions _$UserRequiredActionsFromJson(Map<String, dynamic> json) =>
    UserRequiredActions(
      status: json['status'] as String? ?? '',
      accountType: json['account_type'] as String? ?? '',
    );

Map<String, dynamic> _$UserRequiredActionsToJson(
  UserRequiredActions instance,
) => <String, dynamic>{
  'status': instance.status,
  'account_type': instance.accountType,
};

SignInStepOneRequest _$SignInStepOneRequestFromJson(
  Map<String, dynamic> json,
) => SignInStepOneRequest(
  phoneNumber: json['phone_number'] as String? ?? '',
  locale: json['locale'] as String? ?? '',
);

Map<String, dynamic> _$SignInStepOneRequestToJson(
  SignInStepOneRequest instance,
) => <String, dynamic>{
  'phone_number': instance.phoneNumber,
  'locale': instance.locale,
};

SignInStepTwoRequest _$SignInStepTwoRequestFromJson(
  Map<String, dynamic> json,
) => SignInStepTwoRequest(
  phoneNumber: json['phone_number'] as String? ?? '',
  locale: json['locale'] as String? ?? '',
  code: json['code'] as String? ?? '',
);

Map<String, dynamic> _$SignInStepTwoRequestToJson(
  SignInStepTwoRequest instance,
) => <String, dynamic>{
  'phone_number': instance.phoneNumber,
  'locale': instance.locale,
  'code': instance.code,
};

SignUpKeyRequest _$SignUpKeyRequestFromJson(Map<String, dynamic> json) =>
    SignUpKeyRequest(
      type: json['type'] as String? ?? '',
      recipient: json['recipient'] as String? ?? '',
    );

Map<String, dynamic> _$SignUpKeyRequestToJson(SignUpKeyRequest instance) =>
    <String, dynamic>{'recipient': instance.recipient, 'type': instance.type};

GetVerificationCodeBySendingLogin _$GetVerificationCodeBySendingLoginFromJson(
  Map<String, dynamic> json,
) => GetVerificationCodeBySendingLogin(
  signInKey: json['signin_key'] as String? ?? '',
  type: json['type'] as String? ?? '',
);

Map<String, dynamic> _$GetVerificationCodeBySendingLoginToJson(
  GetVerificationCodeBySendingLogin instance,
) => <String, dynamic>{'signin_key': instance.signInKey, 'type': instance.type};

ResetPasswordToNew _$ResetPasswordToNewFromJson(Map<String, dynamic> json) =>
    ResetPasswordToNew(newPassword: json['new_password'] as String? ?? '');

Map<String, dynamic> _$ResetPasswordToNewToJson(ResetPasswordToNew instance) =>
    <String, dynamic>{'new_password': instance.newPassword};
