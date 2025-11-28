// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$HomeServices extends HomeServices {
  _$HomeServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = HomeServices;

  @override
  Future<Response<List<TeacherModel>>> getTeachersList() {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/teacher/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TeacherModel>, TeacherModel>($request);
  }

  @override
  Future<Response<TeacherModel>> getTeacherById(int id) {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/teacher/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TeacherModel, TeacherModel>($request);
  }
}
