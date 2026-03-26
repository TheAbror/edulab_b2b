// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepModel _$StepModelFromJson(Map<String, dynamic> json) => StepModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  description: json['description'] as String?,
  type: json['type'] as String? ?? '',
  priority: (json['priority'] as num?)?.toInt() ?? 0,
  status:
      $enumDecodeNullable(_$StepItemStatusEnumMap, json['status']) ??
      StepItemStatus.closed,
  media: json['media'] == null
      ? null
      : MediaDTO.fromJson(json['media'] as Map<String, dynamic>),
  text: json['text'] as String?,
  courseId: (json['course_id'] as num?)?.toInt(),
  chapterId: (json['chapter_id'] as num?)?.toInt(),
  topicId: (json['topic_id'] as num?)?.toInt(),
  materials:
      (json['materials'] as List<dynamic>?)
          ?.map((e) => MediaDTO.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  answers:
      (json['questions_answers'] as List<dynamic>?)
          ?.map((e) => QuestionAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$StepModelToJson(StepModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'priority': instance.priority,
  'status': _$StepItemStatusEnumMap[instance.status]!,
  'media': instance.media,
  'text': instance.text,
  'course_id': instance.courseId,
  'chapter_id': instance.chapterId,
  'topic_id': instance.topicId,
  'materials': instance.materials,
  'questions': instance.questions,
  'questions_answers': instance.answers,
};

const _$StepItemStatusEnumMap = {
  StepItemStatus.active: 'ACTIVE',
  StepItemStatus.closed: 'CLOSED',
  StepItemStatus.completed: 'COMPLETED',
};

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      footerText: json['footer_text'] as String?,
      index: (json['index'] as num?)?.toInt() ?? 0,
      type: QuestionType.fromJson(json['type'] as Map<String, dynamic>),
      difficulty: json['difficulty'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      explanationVideo: json['explanation_video'] == null
          ? null
          : MediaDTO.fromJson(
              json['explanation_video'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'footer_text': instance.footerText,
      'index': instance.index,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'priority': instance.priority,
      'options': instance.options,
      'status': instance.status,
      'explanation_video': instance.explanationVideo,
    };

QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) =>
    QuestionOption(
      id: (json['id'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      correct: json['correct'] as bool? ?? false,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QuestionOptionToJson(QuestionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'correct': instance.correct,
      'priority': instance.priority,
    };

QuestionAnswerModel _$QuestionAnswerModelFromJson(Map<String, dynamic> json) =>
    QuestionAnswerModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      number: (json['number'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      type: QuestionType.fromJson(json['type'] as Map<String, dynamic>),
      difficulty: json['difficulty'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      index: (json['index'] as num?)?.toInt() ?? 0,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => AnswerOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      explanationVideo: json['explanation_video'] == null
          ? null
          : MediaDTO.fromJson(
              json['explanation_video'] as Map<String, dynamic>,
            ),
      selectedOptions: (json['selected_options'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$QuestionAnswerModelToJson(
  QuestionAnswerModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'text': instance.text,
  'type': instance.type,
  'difficulty': instance.difficulty,
  'priority': instance.priority,
  'index': instance.index,
  'options': instance.options,
  'status': instance.status,
  'explanation_video': instance.explanationVideo,
  'selected_options': instance.selectedOptions,
};

AnswerOption _$AnswerOptionFromJson(Map<String, dynamic> json) => AnswerOption(
  id: (json['id'] as num?)?.toInt() ?? 0,
  text: json['text'] as String? ?? '',
  value: json['value'] as String?,
);

Map<String, dynamic> _$AnswerOptionToJson(AnswerOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'value': instance.value,
    };

QuizRequest _$QuizRequestFromJson(Map<String, dynamic> json) => QuizRequest(
  stepId: (json['step_id'] as num?)?.toInt() ?? 0,
  answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => NewQuizAnswers.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$QuizRequestToJson(QuizRequest instance) =>
    <String, dynamic>{'step_id': instance.stepId, 'answers': instance.answers};

NewQuizAnswers _$NewQuizAnswersFromJson(Map<String, dynamic> json) =>
    NewQuizAnswers(
      questionID: (json['question_id'] as num?)?.toInt() ?? 0,
      selectedOptionIds:
          (json['selected_option_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$NewQuizAnswersToJson(NewQuizAnswers instance) =>
    <String, dynamic>{
      'question_id': instance.questionID,
      'selected_option_ids': instance.selectedOptionIds,
    };
