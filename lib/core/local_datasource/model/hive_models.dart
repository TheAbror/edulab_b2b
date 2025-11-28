// import 'package:hive/hive.dart';

// part 'hive_models.g.dart';

// @HiveType(typeId: 1)
// class CurrentUser {
//   @HiveField(0)
//   String? token;

//   @HiveField(1)
//   String? userID;

//   @HiveField(2)
//   String? firstName;

//   @HiveField(3)
//   String? lastName;

//   @HiveField(4)
//   String? fullName;

//   @HiveField(5)
//   String? email;

//   @HiveField(6)
//   List<String>? roles;

//   @HiveField(7)
//   String? photo;

//   CurrentUser({
//     this.token,
//     this.userID,
//     this.firstName,
//     this.lastName,
//     this.fullName,
//     this.email,
//     this.roles,
//     this.photo,
//   });
// }

// @HiveType(typeId: 2)
// class ProjectSettings {
//   @HiveField(0)
//   bool? isLight;
//   @HiveField(1)
//   bool? isSystemDefault;
//   @HiveField(2)
//   String? lang;

//   ProjectSettings({
//     this.isLight,
//     this.isSystemDefault,
//     this.lang,
//   });

//   ProjectSettings copyWith({
//     bool? isLight,
//     bool? isSystemDefault,
//     String? lang,
//   }) {
//     return ProjectSettings(
//       isLight: isLight ?? this.isLight,
//       isSystemDefault: isSystemDefault ?? this.isSystemDefault,
//       lang: lang ?? this.lang,
//     );
//   }
// }
