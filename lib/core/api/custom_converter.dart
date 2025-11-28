// ignore_for_file: type_literal_in_constant_pattern

import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

class CustomDataConverter extends JsonConverter {
  @override
  Future<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    final Response<dynamic> dynamicResponse = await super.convertResponse(
      response,
    );

    var body = dynamicResponse.body;

    final BodyType customBody = convertToCustomObject<BodyType, InnerType>(
      body,
    );

    return dynamicResponse.copyWith<BodyType>(body: customBody);
  }
}

BodyType convertToCustomObject<BodyType, SingleItemType>(dynamic element) {
  if (element is List) {
    return deserializeListOf<BodyType, SingleItemType>(element);
  } else {
    return deserialize<SingleItemType>(element);
  }
}

dynamic deserializeListOf<BodyType, SingleItemType>(List dynamicList) {
  List<SingleItemType> list = dynamicList
      .map<SingleItemType>((element) => deserialize<SingleItemType>(element))
      .toList();
  return list;
}

dynamic deserialize<SingleItemType>(Map<String, dynamic> json) {
  switch (SingleItemType) {
    case int:
      return int;

    case AppVersionResponse:
      return AppVersionResponse.fromJson(json);

    case SignUpRequest:
      return SignUpRequest.fromJson(json);

    case AuthResponse:
      return AuthResponse.fromJson(json);

    case SignInRequest:
      return SignInRequest.fromJson(json);

    case MobileResponse:
      return MobileResponse.fromJson(json);

    case TeacherModel:
      return TeacherModel.fromJson(json);

    case CategoryModel:
      return CategoryModel.fromJson(json);

    case CourseShortInfo:
      return CourseShortInfo.fromJson(json);

    case CertificateByTopicIdModel:
      return CertificateByTopicIdModel.fromJson(json);

    case AllTopicsResponse:
      return AllTopicsResponse.fromJson(json);

    case LearningTabStatisticsResponse:
      return LearningTabStatisticsResponse.fromJson(json);

    case SingleCourseInfo:
      return SingleCourseInfo.fromJson(json);

    case TopicModel:
      return TopicModel.fromJson(json);

    default:
      return null;
  }
}
