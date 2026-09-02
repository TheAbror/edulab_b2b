import 'package:edulab_b2b/widget_imports.dart';

class LocalStorageUserInfo {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? account_type_str;
  final String? email;
  final String? phone;
  final String? department;
  final String? jobPosition;
  final String? status;
  final MediaDTO? profile_photo;

  LocalStorageUserInfo({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.account_type_str,
    required this.email,
    required this.status,
    required this.profile_photo,
    this.phone,
    this.department,
    this.jobPosition,
  });

  /// [profile_photo] is passed as a sentinel-free `Object?` so that omitting it
  /// keeps the current photo while passing null clears it.
  LocalStorageUserInfo copyWith({Object? profile_photo = _unset}) {
    return LocalStorageUserInfo(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      account_type_str: account_type_str,
      email: email,
      phone: phone,
      department: department,
      jobPosition: jobPosition,
      status: status,
      profile_photo: identical(profile_photo, _unset)
          ? this.profile_photo
          : profile_photo as MediaDTO?,
    );
  }

  static const Object _unset = Object();

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "username": username ?? '',
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
      "account_type_str": account_type_str ?? '',
      "email": email ?? '',
      "phone": phone ?? '',
      "department": department ?? '',
      "job_position": jobPosition ?? '',
      "status": status ?? '',
      "profile_photo": profile_photo?.toJson(),
    };
  }

  factory LocalStorageUserInfo.fromJson(Map<String, dynamic> json) {
    return LocalStorageUserInfo(
      id: json["id"] ?? 0,
      username: json["username"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? "",
      account_type_str: json["account_type_str"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      department: json["department"] ?? "",
      jobPosition: json["job_position"] ?? "",
      status: json["status"] ?? "",
      profile_photo: json["profile_photo"] != null
          ? MediaDTO.fromJson(json["profile_photo"])
          : null,
    );
  }
}
