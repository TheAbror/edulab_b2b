// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'hive_models.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class CurrentUserAdapter extends TypeAdapter<CurrentUser> {
//   @override
//   final int typeId = 1;

//   @override
//   CurrentUser read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return CurrentUser(
//       token: fields[0] as String?,
//       userID: fields[1] as String?,
//       firstName: fields[2] as String?,
//       lastName: fields[3] as String?,
//       fullName: fields[4] as String?,
//       email: fields[5] as String?,
//       roles: (fields[6] as List?)?.cast<String>(),
//       photo: fields[7] as String?,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, CurrentUser obj) {
//     writer
//       ..writeByte(8)
//       ..writeByte(0)
//       ..write(obj.token)
//       ..writeByte(1)
//       ..write(obj.userID)
//       ..writeByte(2)
//       ..write(obj.firstName)
//       ..writeByte(3)
//       ..write(obj.lastName)
//       ..writeByte(4)
//       ..write(obj.fullName)
//       ..writeByte(5)
//       ..write(obj.email)
//       ..writeByte(6)
//       ..write(obj.roles)
//       ..writeByte(7)
//       ..write(obj.photo);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CurrentUserAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

// class ProjectSettingsAdapter extends TypeAdapter<ProjectSettings> {
//   @override
//   final int typeId = 2;

//   @override
//   ProjectSettings read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return ProjectSettings(
//       isLight: fields[0] as bool?,
//       isSystemDefault: fields[1] as bool?,
//       lang: fields[2] as String?,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, ProjectSettings obj) {
//     writer
//       ..writeByte(3)
//       ..writeByte(0)
//       ..write(obj.isLight)
//       ..writeByte(1)
//       ..write(obj.isSystemDefault)
//       ..writeByte(2)
//       ..write(obj.lang);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ProjectSettingsAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
