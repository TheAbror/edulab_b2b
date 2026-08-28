import 'package:json_annotation/json_annotation.dart';

part 'quiz_response.g.dart';

@JsonSerializable(includeIfNull: true)
class QuizResultResponse {
  @JsonKey(defaultValue: [])
  final List<QuizResponse> content;
  @JsonKey(name: 'quiz_info')
  final QuizInfo quizInfo;

  const QuizResultResponse({
    required this.content,
    required this.quizInfo,
  });

  factory QuizResultResponse.initial() {
    return QuizResultResponse(content: [], quizInfo: QuizInfo.initial());
  }

  factory QuizResultResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QuizInfo {
  @JsonKey(defaultValue: false)
  final bool passed;
  @JsonKey(defaultValue: 0, name: 'total_questions')
  final int totalQuestions;
  @JsonKey(defaultValue: 0, name: 'correct_answers')
  final int correctAnswers;
  @JsonKey(defaultValue: 0, name: 'incorrect_answers')
  final int incorrectAnswers;
  @JsonKey(defaultValue: 0, name: 'score_percentage')
  final double scorePercentage;

  QuizInfo({
    required this.passed,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.scorePercentage,
  });

  factory QuizInfo.initial() {
    return QuizInfo(
      passed: false,
      totalQuestions: 0,
      correctAnswers: 0,
      incorrectAnswers: 0,
      scorePercentage: 0,
    );
  }

  factory QuizInfo.fromJson(Map<String, dynamic> json) =>
      _$QuizInfoFromJson(json);
  Map<String, dynamic> toJson() => _$QuizInfoToJson(this);
}

enum QuizStatus {
  @JsonValue('CORRECT')
  correct,
  @JsonValue('INCORRECT')
  incorrect,
  @JsonValue('UNKNOWN')
  unknown,
}

enum StepItemStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('CLOSED')
  closed,
  @JsonValue('COMPLETED')
  completed,
}

enum QuestionTypeValue {
  @JsonValue('SINGLE_CHOICE')
  singleChoice,
  @JsonValue('MULTIPLE_CHOICE')
  multipleChoice,
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
  final List<QuizAnswerOption> options;
  @JsonKey(
    defaultValue: QuizStatus.unknown,
    unknownEnumValue: QuizStatus.unknown,
  )
  final QuizStatus status;
  @JsonKey(name: 'explanation_video')
  final MediaDTO? explanationVideo;
  @JsonKey(name: 'selected_options', defaultValue: [])
  final List<QuizAnswerOption> selectedOptions;

  const QuizResponse({
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
class QuestionType {
  @JsonKey(defaultValue: '')
  final String label;
  final QuestionTypeValue value;
  final String? icon;
  final String? color;

  const QuestionType({
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
class QuizAnswerOption {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String text;
  final bool? value; // null, true, or false

  const QuizAnswerOption({
    required this.id,
    required this.text,
    this.value,
  });

  factory QuizAnswerOption.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerOptionFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerOptionToJson(this);
}

@JsonSerializable(includeIfNull: true)
class MediaDTO {
  // The backend sometimes returns partial media objects (e.g. an empty
  // preview_video), so every field tolerates a missing / null value.
  @JsonKey(defaultValue: '')
  final String src;
  @JsonKey(name: 'original_name', defaultValue: '')
  final String originalName;
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(name: 'file_size_str', defaultValue: '')
  final String fileSizeStr;
  @JsonKey(name: 'original_url', defaultValue: '')
  final String originalUrl;
  @JsonKey(name: 'thumb_url', defaultValue: '')
  final String thumbUrl;
  @JsonKey(name: 'file_size', defaultValue: 0)
  final int fileSize;
  @JsonKey(defaultValue: '')
  final String extension;

  const MediaDTO({
    required this.src,
    required this.originalName,
    required this.url,
    required this.fileSizeStr,
    required this.originalUrl,
    required this.thumbUrl,
    required this.fileSize,
    required this.extension,
  });
  static MediaDTO initial() => const MediaDTO(
    src: '',
    originalName: '',
    url: '',
    fileSizeStr: '',
    originalUrl: '',
    thumbUrl: '',
    fileSize: 0,
    extension: '',
  );
  factory MediaDTO.fromJson(Map<String, dynamic> json) =>
      _$MediaDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDTOToJson(this);
}
