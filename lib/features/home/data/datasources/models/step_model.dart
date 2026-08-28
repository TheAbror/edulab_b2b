import 'package:json_annotation/json_annotation.dart';

import 'package:edulab_b2b/widget_imports.dart';

part 'step_model.g.dart';

@JsonSerializable(includeIfNull: true)
class StepModel extends Equatable {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  final String? description;
  @JsonKey(defaultValue: '')
  final String type;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(
    defaultValue: StepItemStatus.closed,
    unknownEnumValue: StepItemStatus.closed,
  )
  final StepItemStatus status;
  final MediaDTO? media;
  final String? text;
  @JsonKey(name: 'course_id')
  final int? courseId;
  @JsonKey(name: 'chapter_id')
  final int? chapterId;
  @JsonKey(name: 'topic_id')
  final int? topicId;
  @JsonKey(defaultValue: [])
  final List<MediaDTO> materials;
  @JsonKey(defaultValue: [])
  final List<QuestionModel> questions;
  @JsonKey(defaultValue: [], name: 'questions_answers')
  final List<QuestionAnswerModel> answers;

  const StepModel({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.priority,
    required this.status,
    this.media,
    this.text,
    this.courseId,
    this.chapterId,
    this.topicId,
    required this.materials,
    required this.questions,
    required this.answers,
  });

  factory StepModel.initial() {
    return StepModel(
      id: 0,
      title: '',
      description: '',
      priority: 0,
      type: '',
      status: StepItemStatus.closed,
      materials: [],
      answers: [],
      questions: [],
    );
  }

  factory StepModel.fromJson(Map<String, dynamic> json) =>
      _$StepModelFromJson(json);
  Map<String, dynamic> toJson() => _$StepModelToJson(this);

  StepModel copyWith({
    int? id,
    String? title,
    String? description,
    String? type,
    int? priority,
    StepItemStatus? status,
    MediaDTO? media,
    String? text,
    int? courseId,
    int? chapterId,
    int? topicId,
    List<MediaDTO>? materials,
    List<QuestionModel>? questions,
    List<QuestionAnswerModel>? answers,
  }) {
    return StepModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      media: media ?? this.media,
      text: text ?? this.text,
      courseId: courseId ?? this.courseId,
      chapterId: chapterId ?? this.chapterId,
      topicId: topicId ?? this.topicId,
      materials: materials ?? this.materials,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
    );
  }

  @override
  List<Object?> get props => [id, type, status];
}

@JsonSerializable(includeIfNull: true)
class QuestionModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(name: 'footer_text')
  final String? footerText;
  @JsonKey(defaultValue: 0)
  final int index;
  // Nullable: the backend omits `type` on some step payloads (e.g. course/{id}).
  final QuestionType? type;
  @JsonKey(defaultValue: '')
  final String difficulty;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(defaultValue: [])
  final List<QuestionOption> options;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(name: 'explanation_video')
  final MediaDTO? explanationVideo;

  QuestionModel({
    required this.id,
    required this.text,
    this.footerText,
    required this.index,
    this.type,
    required this.difficulty,
    required this.priority,
    required this.options,
    required this.status,
    this.explanationVideo,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QuestionOption {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: false)
  final bool correct;
  @JsonKey(defaultValue: 0)
  final int priority;

  QuestionOption({
    required this.id,
    required this.text,
    required this.correct,
    required this.priority,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionOptionToJson(this);
}

// `selected_options` comes back either as a list of ids ([1, 2]) or as a list of
// option objects ([{id: 1, ...}]); normalise both to a list of ids.
Object? _readSelectedOptionIds(Map<dynamic, dynamic> json, String key) {
  final raw = json['selected_options'];
  if (raw is! List) return raw;
  return raw.map((e) => e is Map ? e['id'] : e).toList();
}

@JsonSerializable(includeIfNull: true)
class QuestionAnswerModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int number;
  @JsonKey(defaultValue: '')
  final String text;
  final QuestionType? type;
  @JsonKey(defaultValue: '')
  final String difficulty;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(defaultValue: 0)
  final int index;
  @JsonKey(defaultValue: [])
  final List<AnswerOption> options;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(name: 'explanation_video')
  final MediaDTO? explanationVideo;
  @JsonKey(name: 'selected_options', readValue: _readSelectedOptionIds)
  final List<int>? selectedOptions;

  QuestionAnswerModel({
    required this.id,
    required this.number,
    required this.text,
    this.type,
    required this.difficulty,
    required this.priority,
    required this.index,
    required this.options,
    required this.status,
    this.explanationVideo,
    this.selectedOptions,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionAnswerModelToJson(this);
}

// `value` is sometimes a string, sometimes a nested object; only keep it when
// it's a plain string so parsing never throws.
Object? _readAnswerOptionValue(Map<dynamic, dynamic> json, String key) {
  final value = json['value'];
  return value is String ? value : null;
}

@JsonSerializable(includeIfNull: true)
class AnswerOption {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(readValue: _readAnswerOptionValue)
  final String? value;

  AnswerOption({
    required this.id,
    required this.text,
    this.value,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) =>
      _$AnswerOptionFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerOptionToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QuizRequest {
  @JsonKey(name: 'step_id', defaultValue: 0)
  final int stepId;
  @JsonKey(defaultValue: [])
  final List<NewQuizAnswers> answers;

  QuizRequest({
    required this.stepId,
    required this.answers,
  });

  factory QuizRequest.initial() {
    return QuizRequest(
      stepId: 0,
      answers: [],
    );
  }

  factory QuizRequest.fromJson(Map<String, dynamic> json) =>
      _$QuizRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuizRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class NewQuizAnswers {
  @JsonKey(name: 'question_id', defaultValue: 0)
  final int questionID;
  @JsonKey(name: 'selected_option_ids', defaultValue: [])
  final List<String> selectedOptionIds;

  NewQuizAnswers({
    required this.questionID,
    required this.selectedOptionIds,
  });

  factory NewQuizAnswers.initial() {
    return NewQuizAnswers(
      questionID: 0,
      selectedOptionIds: [],
    );
  }

  factory NewQuizAnswers.fromJson(Map<String, dynamic> json) =>
      _$NewQuizAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$NewQuizAnswersToJson(this);
}
