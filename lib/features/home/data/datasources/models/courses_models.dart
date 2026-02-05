import 'package:json_annotation/json_annotation.dart';
import 'package:leti_mobile/features/home/data/datasources/models/chapter_model.dart';

part 'courses_models.g.dart';

@JsonSerializable(includeIfNull: true)
class HomeCoursesResponse {
  @JsonKey(defaultValue: [])
  final List<CourseShortInfo> content;

  HomeCoursesResponse({required this.content});

  factory HomeCoursesResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeCoursesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeCoursesResponseToJson(this);
}

@JsonSerializable()
class MediaDTO {
  @JsonKey(defaultValue: '')
  final String? original_name;
  @JsonKey(defaultValue: '')
  final String? src;
  @JsonKey(defaultValue: 0)
  final int? file_size;
  @JsonKey(defaultValue: '')
  final String? original_url;
  @JsonKey(defaultValue: '')
  final String? thumb_url;
  @JsonKey(defaultValue: '')
  final String? url;
  @JsonKey(defaultValue: '')
  final String? extension;

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
class SyllabusResponse {
  @JsonKey(defaultValue: [], name: 'study_goals')
  final List<String>? studyGoals;
  @JsonKey(defaultValue: [], name: 'course_content')
  final List<ChapterModel>? courseContent;

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
  final MediaDTO? file;
  final LanguageLevel? language;
  final LanguageLevel? level;
  @JsonKey(defaultValue: [])
  final List<LabelValueAsIntResponse> skills;
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
  final String? completionTime;
  @JsonKey(defaultValue: '')
  final String price;
  // final Map<String, dynamic>? structure;
  @JsonKey(defaultValue: [])
  final List<ChapterModel> chapters;
  @JsonKey(name: 'current_active')
  final CurrentlyActive? currentlyActive;

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
    required this.price,
    this.updatedDate,
    this.courseStatus,
    // this.xapiCourseUrl,
    this.file,
    this.language,
    this.level,
    required this.skills,
    required this.coAuthorIds,
    this.status,
    required this.learnersCount,
    this.syllabus,
    this.progress,
    this.published,
    this.canPublish,
    this.completionTime,
    // this.structure,
    required this.chapters,
    this.currentlyActive,
  });

  factory SingleCourseInfo.fromJson(Map<String, dynamic> json) =>
      _$SingleCourseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCourseInfoToJson(this);
}

@JsonSerializable()
class LabelValueAsIntResponse {
  @JsonKey(defaultValue: "")
  final String label;
  @JsonKey(defaultValue: 0)
  final int value;

  LabelValueAsIntResponse({required this.label, required this.value});

  factory LabelValueAsIntResponse.fromJson(Map<String, dynamic> json) =>
      _$LabelValueAsIntResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LabelValueAsIntResponseToJson(this);
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

  @JsonKey(name: "course_status")
  final LabelValueResponse? courseStatus;

  // @JsonKey(name: "xapi_course_url")
  // final String? xapiCourseUrl;

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

  @JsonKey(defaultValue: "")
  final String? price;

  @JsonKey(defaultValue: 0, name: 'overall_progress')
  final int progess;

  @JsonKey(name: "learners_count", defaultValue: 0)
  final int learnersCount;
  // "4.6"
  @JsonKey(defaultValue: '')
  final String rating;

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
    this.courseStatus,
    // this.xapiCourseUrl,
    this.file,
    this.language,
    this.level,
    this.willLearn,
    this.price,
    this.coAuthorIds,
    this.status,
    required this.progess,
    required this.rating,
    required this.learnersCount,
  });

  factory CourseShortInfo.fromJson(Map<String, dynamic> json) =>
      _$CourseShortInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CourseShortInfoToJson(this);
}

//  "current_active": {
//         "chapter_id": 6738,
//         "topic_id": 6757,
//         "step_id": 6773
//     }

@JsonSerializable()
class CurrentlyActive {
  @JsonKey(defaultValue: 0, name: 'chapter_id')
  final int chapterID;
  @JsonKey(defaultValue: 0, name: 'topic_id')
  final int topicID;
  @JsonKey(defaultValue: 0, name: 'step_id')
  final int stepID;

  CurrentlyActive({
    required this.chapterID,
    required this.topicID,
    required this.stepID,
  });

  factory CurrentlyActive.fromJson(Map<String, dynamic> json) =>
      _$CurrentlyActiveFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentlyActiveToJson(this);
}

@JsonSerializable(includeIfNull: true)
class MakeCourseFavoriteRequest {
  @JsonKey(defaultValue: 0, name: 'course_id')
  final int courseID;

  MakeCourseFavoriteRequest({required this.courseID});

  factory MakeCourseFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$MakeCourseFavoriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MakeCourseFavoriteRequestToJson(this);
}
