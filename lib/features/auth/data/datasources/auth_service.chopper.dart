// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthService;

  @override
  Future<Response<MobileResponse>> signInStepOne(SignInStepOneRequest body) {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/signin/step_one',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MobileResponse, MobileResponse>($request);
  }

  @override
  Future<Response<AuthResponse>> signInStepTwo(SignInStepTwoRequest body) {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/signin/step_two',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AuthResponse, AuthResponse>($request);
  }

  @override
  Future<Response<AuthResponse>> signInStepThree(SignInStepThreeRequest body) {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/signin/step_three',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AuthResponse, AuthResponse>($request);
  }

  @override
  Future<Response<MobileResponse>> sendSignUpKeyForVerification(
    SignUpKeyRequest body,
  ) {
    final Uri $url = Uri.parse(
      'https://944b-213-230-79-129.ngrok-free.app/verify_code/send',
    );
    final $body = body;
    final Request $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<MobileResponse, MobileResponse>($request);
  }
}
