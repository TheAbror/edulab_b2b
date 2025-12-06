import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leti_mobile/features/home/data/datasources/models/courses_models.dart';

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
  @JsonKey(defaultValue: '')
  final String status;
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
      status: '',
      materials: [],
      answers: [],
      questions: [],
    );
  }

  factory StepModel.fromJson(Map<String, dynamic> json) =>
      _$StepModelFromJson(json);
  Map<String, dynamic> toJson() => _$StepModelToJson(this);

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
  final QuestionType type;
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
    required this.type,
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
class QuestionType {
  @JsonKey(defaultValue: '')
  final String label;
  @JsonKey(defaultValue: '')
  final String value;
  final String? icon;
  final String? color;

  QuestionType({
    required this.label,
    required this.value,
    this.icon,
    this.color,
  });

  factory QuestionType.fromJson(Map<String, dynamic> json) =>
      _$QuestionTypeFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionTypeToJson(this);
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

@JsonSerializable(includeIfNull: true)
class QuestionAnswerModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int number;
  @JsonKey(defaultValue: '')
  final String text;
  final QuestionType type;
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
  @JsonKey(name: 'selected_options')
  final List<int>? selectedOptions;

  QuestionAnswerModel({
    required this.id,
    required this.number,
    required this.text,
    required this.type,
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

@JsonSerializable(includeIfNull: true)
class AnswerOption {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
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
  @JsonKey(name: 'question_id', defaultValue: 0)
  final int questionId;
  @JsonKey(name: 'step_id', defaultValue: 0)
  final int stepId;
  @JsonKey(name: 'selected_option_ids', defaultValue: [])
  final List<String> selectedOptionIds;

  QuizRequest({
    required this.questionId,
    required this.stepId,
    required this.selectedOptionIds,
  });

  factory QuizRequest.fromJson(Map<String, dynamic> json) =>
      _$QuizRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuizRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QuizResponse {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0)
  final int number;
  @JsonKey(defaultValue: '')
  final String text;
  final QuestionType type;
  @JsonKey(defaultValue: '')
  final String difficulty;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(defaultValue: 0)
  final int index;
  @JsonKey(defaultValue: [])
  final List<QuizResponseAnswerOption> options;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(name: 'explanation_video')
  final MediaDTO? explanationVideo;
  @JsonKey(name: 'selected_options', defaultValue: [])
  final List<QuizResponseAnswerOption> selectedOptions;

  QuizResponse({
    required this.id,
    required this.number,
    required this.text,
    required this.type,
    required this.difficulty,
    required this.priority,
    required this.index,
    required this.options,
    required this.status,
    this.explanationVideo,
    required this.selectedOptions,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QuizResponseAnswerOption {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
  final bool? value;

  QuizResponseAnswerOption({
    required this.id,
    required this.text,
    this.value,
  });

  factory QuizResponseAnswerOption.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseAnswerOptionFromJson(json);
  Map<String, dynamic> toJson() => _$QuizResponseAnswerOptionToJson(this);
}

// chapter_id, topic_id, step_id

@JsonSerializable()
class CompleteStepRequest {
  @JsonKey(defaultValue: 0, name: 'chapter_id')
  final int chapterID;
  @JsonKey(defaultValue: 0, name: 'topic_id')
  final int topicID;
  @JsonKey(defaultValue: 0, name: 'step_id')
  final int stepID;

  CompleteStepRequest({
    required this.chapterID,
    required this.topicID,
    required this.stepID,
  });

  factory CompleteStepRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteStepRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteStepRequestToJson(this);
}
