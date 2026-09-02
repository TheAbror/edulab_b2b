// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'profile_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ProfileServices extends ProfileServices {
  _$ProfileServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ProfileServices;

  @override
  Future<Response<ProfileResponse>> updateProfile(ProfileUpdateRequest body) {
    final Uri $url = Uri.parse(
      'https://7e3e-213-230-79-129.ngrok-free.app/edulab/api/v1/core/mobile/profile/',
    );
    final $body = body;
    final Request $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<ProfileResponse, ProfileResponse>($request);
  }
}
