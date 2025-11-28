import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'certificates_service.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class CertificatesServices extends ChopperService {
  static CertificatesServices create([ChopperClient? client]) =>
      _$CertificatesServices(client ?? ChopperClient());

  // @Get(path: AppStrings.topicsAll)
  // Future<Response<AllTopicsResponse>> getAllTopics();

  // @Get(path: AppStrings.certificate)
  // Future<Response<List<CertificateByTopicIdModel>>> getAllCertificates();

  @Get(path: '${AppStrings.certificate}?topic_id={id}')
  Future<Response<List<CertificateByTopicIdModel>>> getCertificatesByTopicID(
    @Path('id') int id,
  );
}
