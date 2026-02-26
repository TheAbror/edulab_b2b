// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse(
  id: (json['id'] as num?)?.toInt() ?? 0,
  number: (json['number'] as num?)?.toInt() ?? 0,
  text: json['text'] as String? ?? '',
  type: QuestionType.fromJson(json['type'] as Map<String, dynamic>),
  difficulty: json['difficulty'] as String? ?? '',
  priority: (json['priority'] as num?)?.toInt() ?? 0,
  index: (json['index'] as num?)?.toInt() ?? 0,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => QuizAnswerOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  status:
      $enumDecodeNullable(
        _$QuizStatusEnumMap,
        json['status'],
        unknownValue: QuizStatus.unknown,
      ) ??
      QuizStatus.unknown,
  explanationVideo: json['explanation_video'] == null
      ? null
      : MediaDTO.fromJson(json['explanation_video'] as Map<String, dynamic>),
  selectedOptions:
      (json['selected_options'] as List<dynamic>?)
          ?.map((e) => QuizAnswerOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'text': instance.text,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'priority': instance.priority,
      'index': instance.index,
      'options': instance.options,
      'status': _$QuizStatusEnumMap[instance.status]!,
      'explanation_video': instance.explanationVideo,
      'selected_options': instance.selectedOptions,
    };

const _$QuizStatusEnumMap = {
  QuizStatus.correct: 'CORRECT',
  QuizStatus.incorrect: 'INCORRECT',
  QuizStatus.unknown: 'UNKNOWN',
};

QuestionType _$QuestionTypeFromJson(Map<String, dynamic> json) => QuestionType(
  label: json['label'] as String? ?? '',
  value: $enumDecode(_$QuestionTypeValueEnumMap, json['value']),
  icon: json['icon'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$QuestionTypeToJson(QuestionType instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': _$QuestionTypeValueEnumMap[instance.value]!,
      'icon': instance.icon,
      'color': instance.color,
    };

const _$QuestionTypeValueEnumMap = {
  QuestionTypeValue.singleChoice: 'SINGLE_CHOICE',
  QuestionTypeValue.multipleChoice: 'MULTIPLE_CHOICE',
};

QuizAnswerOption _$QuizAnswerOptionFromJson(Map<String, dynamic> json) =>
    QuizAnswerOption(
      id: (json['id'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      value: json['value'] as bool?,
    );

Map<String, dynamic> _$QuizAnswerOptionToJson(QuizAnswerOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'value': instance.value,
    };

MediaDTO _$MediaDTOFromJson(Map<String, dynamic> json) => MediaDTO(
  src: json['src'] as String,
  originalName: json['original_name'] as String,
  url: json['url'] as String,
  fileSizeStr: json['file_size_str'] as String,
  originalUrl: json['original_url'] as String,
  thumbUrl: json['thumb_url'] as String,
  fileSize: (json['file_size'] as num).toInt(),
  extension: json['extension'] as String,
);

Map<String, dynamic> _$MediaDTOToJson(MediaDTO instance) => <String, dynamic>{
  'src': instance.src,
  'original_name': instance.originalName,
  'url': instance.url,
  'file_size_str': instance.fileSizeStr,
  'original_url': instance.originalUrl,
  'thumb_url': instance.thumbUrl,
  'file_size': instance.fileSize,
  'extension': instance.extension,
};
