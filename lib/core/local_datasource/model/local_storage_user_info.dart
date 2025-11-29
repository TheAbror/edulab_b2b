class LocalStorageUserInfo {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;

  LocalStorageUserInfo({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? 0,
      "username": username ?? '',
      "firstName": firstName ?? '',
      "lastName": lastName ?? '',
    };
  }

  factory LocalStorageUserInfo.fromJson(Map<String, dynamic> json) {
    return LocalStorageUserInfo(
      id: json["id"] ?? 0,
      username: json["username"] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? "",
    );
  }
}
