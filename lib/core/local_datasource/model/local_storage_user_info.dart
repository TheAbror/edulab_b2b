import 'package:edulab_b2b/widget_imports.dart';

class LocalStorageUserInfo {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? account_type_str;
  final String? email;
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
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "username": username ?? '',
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
      "account_type_str": account_type_str ?? '',
      "email": email ?? '',
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
      status: json["status"] ?? "",
      profile_photo: json["profile_photo"] != null
          ? MediaDTO.fromJson(json["profile_photo"])
          : null,
    );
  }
}
