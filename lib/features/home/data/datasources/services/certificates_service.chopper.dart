// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CertificatesServices extends CertificatesServices {
  _$CertificatesServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CertificatesServices;

  @override
  Future<Response<List<CertificateByTopicIdModel>>> getCertificatesByTopicID(
      int id) {
    final Uri $url = Uri.parse(
        'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/certificate/?topic_id=${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CertificateByTopicIdModel>,
        CertificateByTopicIdModel>($request);
  }
}
