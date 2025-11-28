import 'package:json_annotation/json_annotation.dart';

part 'courses_models.g.dart';

@JsonSerializable(includeIfNull: true)
class MakeCourseFavoriteRequest {
  @JsonKey(defaultValue: 0, name: 'course_id')
  final int courseID;

  MakeCourseFavoriteRequest({
    required this.courseID,
  });

  factory MakeCourseFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$MakeCourseFavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MakeCourseFavoriteRequestToJson(this);
}

@JsonSerializable()
class MediaDTO {
  @JsonKey(defaultValue: '')
  final String original_name;
  @JsonKey(defaultValue: '')
  final String src;
  @JsonKey(defaultValue: 0)
  final int file_size;
  @JsonKey(defaultValue: '')
  final String original_url;
  @JsonKey(defaultValue: '')
  final String thumb_url;
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(defaultValue: '')
  final String extension;

  MediaDTO({
    required this.original_name,
    required this.src,
    required this.file_size,
    required this.original_url,
    required this.thumb_url,
    required this.url,
    required this.extension,
  });

  factory MediaDTO.fromJson(Map<String, dynamic> json) =>
      _$MediaDTOFromJson(json);
  Map<String, dynamic> toJson() => _$MediaDTOToJson(this);
}

@JsonSerializable()
class Authors {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: 0, name: 'user_id')
  final int userId;
  @JsonKey(defaultValue: "")
  final String about;
  @JsonKey(defaultValue: 0, name: 'course_count')
  final int courseCount;
  @JsonKey(defaultValue: "")
  final String firstname;
  @JsonKey(name: 'job_position', defaultValue: "")
  final String jobPosition;
  @JsonKey(defaultValue: "")
  final String lastname;
  final MediaDTO? avatar;

  Authors({
    required this.id,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.jobPosition,
    required this.about,
    required this.courseCount,
    this.avatar,
  });

  factory Authors.fromJson(Map<String, dynamic> json) =>
      _$AuthorsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorsToJson(this);
}

@JsonSerializable()
class CategoryModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: "")
  final String title;

  CategoryModel({required this.id, required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class LabelValueResponse {
  @JsonKey(defaultValue: "")
  final String label;
  @JsonKey(defaultValue: "")
  final String value;

  LabelValueResponse({required this.label, required this.value});

  factory LabelValueResponse.fromJson(Map<String, dynamic> json) =>
      _$LabelValueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LabelValueResponseToJson(this);
}

@JsonSerializable()
class CourseType {
  @JsonKey(defaultValue: "")
  final String value;
  @JsonKey(defaultValue: "")
  final String label;

  CourseType({required this.value, required this.label});

  factory CourseType.fromJson(Map<String, dynamic> json) =>
      _$CourseTypeFromJson(json);
  Map<String, dynamic> toJson() => _$CourseTypeToJson(this);
}

@JsonSerializable()
class LanguageLevel {
  @JsonKey(defaultValue: 0)
  final int value;
  @JsonKey(defaultValue: "")
  final String label;

  LanguageLevel({required this.value, required this.label});

  factory LanguageLevel.fromJson(Map<String, dynamic> json) =>
      _$LanguageLevelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageLevelToJson(this);
}

@JsonSerializable()
class Status {
  @JsonKey(defaultValue: '')
  final String value;
  @JsonKey(defaultValue: '')
  final String label;

  Status({required this.value, required this.label});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable(includeIfNull: true)
class StepModel {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
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
  final List<dynamic> materials;
  @JsonKey(defaultValue: [])
  final List<dynamic> questions;
  final dynamic answers;
  final String? url;

  StepModel({
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
    this.answers,
    this.url,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) =>
      _$StepModelFromJson(json);
  Map<String, dynamic> toJson() => _$StepModelToJson(this);
}

@JsonSerializable(includeIfNull: true)
class CourseTopicsResponse {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String? description;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(name: 'course_id')
  final int? courseId;
  @JsonKey(name: 'chapter_id')
  final int? chapterId;
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(name: 'steps_info')
  final dynamic stepsInfo;
  @JsonKey(defaultValue: [])
  final List<StepModel> steps;

  CourseTopicsResponse({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    this.courseId,
    this.chapterId,
    required this.status,
    this.stepsInfo,
    required this.steps,
  });

  factory CourseTopicsResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseTopicsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseTopicsResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class CourseContent {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: 0)
  final int priority;
  @JsonKey(defaultValue: [])
  final List<CourseTopicsResponse> topics;

  CourseContent({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.topics,
  });

  factory CourseContent.fromJson(Map<String, dynamic> json) =>
      _$CourseContentFromJson(json);
  Map<String, dynamic> toJson() => _$CourseContentToJson(this);
}

@JsonSerializable(includeIfNull: true)
class SyllabusResponse {
  @JsonKey(defaultValue: [], name: 'study_goals')
  final List<String>? studyGoals;
  @JsonKey(defaultValue: [], name: 'course_content')
  final List<CourseContent>? courseContent;

  SyllabusResponse({required this.studyGoals, this.courseContent});

  factory SyllabusResponse.fromJson(Map<String, dynamic> json) =>
      _$SyllabusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SyllabusResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class SingleCourseInfo {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: [])
  final List<String> description;
  @JsonKey(defaultValue: "")
  final String shortDescription;
  @JsonKey(defaultValue: [])
  final List<Authors> authors;
  @JsonKey(defaultValue: [])
  final List<Authors> co_authors;
  @JsonKey(name: 'cover_image')
  final MediaDTO? thumbnail;
  @JsonKey(name: 'preview_video')
  final MediaDTO? previewVideo;
  final CategoryModel? category;
  @JsonKey(defaultValue: false)
  final bool? is_favorite;
  @JsonKey(defaultValue: false)
  final bool? is_archived;
  @JsonKey()
  final CourseType? type;
  @JsonKey(name: "created_date")
  final int? createdDate;
  @JsonKey(name: "updated_date")
  final int? updatedDate;
  @JsonKey(name: "course_status")
  final LabelValueResponse? courseStatus;
  @JsonKey(name: "xapi_course_url")
  final String? xapiCourseUrl;
  final MediaDTO? file;
  final LanguageLevel? language;
  final LanguageLevel? level;
  @JsonKey(name: "will_learn", defaultValue: [])
  final List<String> willLearn;
  @JsonKey(defaultValue: [])
  final List<String> prerequisites;
  @JsonKey(defaultValue: [])
  final List<String> skills;
  @JsonKey(name: "co_author_ids", defaultValue: [])
  final List<int> coAuthorIds;
  final Status? status;
  @JsonKey(name: "learners_count", defaultValue: 0)
  final int learnersCount;
  final SyllabusResponse? syllabus;
  final int? progress;
  final bool? published;
  final bool? canPublish;
  @JsonKey(name: "completion_time")
  final dynamic completionTime;
  final Map<String, dynamic>? structure;
  @JsonKey(defaultValue: [])
  final List<CourseContent> chapters;

  SingleCourseInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.authors,
    required this.co_authors,
    this.thumbnail,
    this.previewVideo,
    this.category,
    this.is_favorite,
    this.is_archived,
    this.type,
    this.createdDate,
    this.updatedDate,
    this.courseStatus,
    this.xapiCourseUrl,
    this.file,
    this.language,
    this.level,
    required this.willLearn,
    required this.prerequisites,
    required this.skills,
    required this.coAuthorIds,
    this.status,
    required this.learnersCount,
    this.syllabus,
    this.progress,
    this.published,
    this.canPublish,
    this.completionTime,
    this.structure,
    required this.chapters,
  });

  factory SingleCourseInfo.fromJson(Map<String, dynamic> json) =>
      _$SingleCourseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCourseInfoToJson(this);
}

@JsonSerializable(includeIfNull: true)
class CourseShortInfo {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: [])
  final List<String> description;

  @JsonKey(defaultValue: "")
  final String short_description;

  @JsonKey(defaultValue: [])
  final List<Authors> authors;

  @JsonKey(defaultValue: [])
  final List<Authors> co_authors;

  @JsonKey(name: 'cover_image')
  final MediaDTO? thumbnail;

  @JsonKey(name: 'preview_video')
  final MediaDTO? previewVideo;

  final CategoryModel category;

  @JsonKey(defaultValue: false)
  final bool? is_favorite;

  @JsonKey(defaultValue: false)
  final bool? is_archived;

  @JsonKey()
  final CourseType? type;

  @JsonKey(name: "created_date")
  final int? createdDate;

  @JsonKey(name: "updated_date")
  final int? updatedDate;

  @JsonKey(name: "course_status")
  final LabelValueResponse? courseStatus;

  @JsonKey(name: "xapi_course_url")
  final String? xapiCourseUrl;

  @JsonKey()
  final MediaDTO? file;

  @JsonKey(defaultValue: '')
  final String? language;

  @JsonKey(defaultValue: '')
  final String? level;

  @JsonKey(name: "will_learn")
  final List<String>? willLearn;

  @JsonKey(name: "co_author_ids")
  final List<int>? coAuthorIds;

  @JsonKey(defaultValue: "")
  final String? status;

  @JsonKey(name: "learners_count", defaultValue: 0)
  final int learnersCount;

  CourseShortInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.short_description,
    required this.authors,
    required this.co_authors,
    this.thumbnail,
    this.previewVideo,
    required this.category,
    this.is_favorite,
    this.is_archived,
    this.type,
    this.createdDate,
    this.updatedDate,
    this.courseStatus,
    this.xapiCourseUrl,
    this.file,
    this.language,
    this.level,
    this.willLearn,
    this.coAuthorIds,
    this.status,
    required this.learnersCount,
  });

  factory CourseShortInfo.fromJson(Map<String, dynamic> json) =>
      _$CourseShortInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CourseShortInfoToJson(this);
}
