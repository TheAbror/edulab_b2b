// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateByTopicIdModel _$CertificateByTopicIdModelFromJson(
  Map<String, dynamic> json,
) => CertificateByTopicIdModel(
  title: json['title'] as String? ?? '',
  file: MediaDTO.fromJson(json['file'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CertificateByTopicIdModelToJson(
  CertificateByTopicIdModel instance,
) => <String, dynamic>{'title': instance.title, 'file': instance.file};

AllTopicsResponse _$AllTopicsResponseFromJson(Map<String, dynamic> json) =>
    AllTopicsResponse(
      total_elements: (json['total_elements'] as num?)?.toInt() ?? 0,
      content:
          (json['content'] as List<dynamic>?)
              ?.map(
                (e) => AllTopicsContentResponse.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$AllTopicsResponseToJson(AllTopicsResponse instance) =>
    <String, dynamic>{
      'total_elements': instance.total_elements,
      'content': instance.content,
    };

AllTopicsContentResponse _$AllTopicsContentResponseFromJson(
  Map<String, dynamic> json,
) => AllTopicsContentResponse(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$AllTopicsContentResponseToJson(
  AllTopicsContentResponse instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
