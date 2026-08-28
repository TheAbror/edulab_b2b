// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCoursesResponse _$HomeCoursesResponseFromJson(Map<String, dynamic> json) =>
    HomeCoursesResponse(
      content:
          (json['content'] as List<dynamic>?)
              ?.map((e) => CourseShortInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HomeCoursesResponseToJson(
  HomeCoursesResponse instance,
) => <String, dynamic>{'content': instance.content};

Authors _$AuthorsFromJson(Map<String, dynamic> json) => Authors(
  id: (json['id'] as num?)?.toInt() ?? 0,
  userId: (json['user_id'] as num?)?.toInt() ?? 0,
  firstname: json['firstname'] as String? ?? '',
  lastname: json['lastname'] as String? ?? '',
  jobPosition: json['job_position'] as String? ?? '',
  about: json['about'] as String? ?? '',
  courseCount: (json['course_count'] as num?)?.toInt() ?? 0,
  avatar: json['avatar'] == null
      ? null
      : MediaDTO.fromJson(json['avatar'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthorsToJson(Authors instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'about': instance.about,
  'course_count': instance.courseCount,
  'firstname': instance.firstname,
  'job_position': instance.jobPosition,
  'lastname': instance.lastname,
  'avatar': instance.avatar,
};

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

LabelValueResponse _$LabelValueResponseFromJson(Map<String, dynamic> json) =>
    LabelValueResponse(
      label: json['label'] as String? ?? '',
      value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$LabelValueResponseToJson(LabelValueResponse instance) =>
    <String, dynamic>{'label': instance.label, 'value': instance.value};

CourseType _$CourseTypeFromJson(Map<String, dynamic> json) => CourseType(
  value: json['value'] as String? ?? '',
  label: json['label'] as String? ?? '',
);

Map<String, dynamic> _$CourseTypeToJson(CourseType instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

LanguageLevel _$LanguageLevelFromJson(Map<String, dynamic> json) =>
    LanguageLevel(
      value: (json['value'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$LanguageLevelToJson(LanguageLevel instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  value: json['value'] as String? ?? '',
  label: json['label'] as String? ?? '',
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'value': instance.value,
  'label': instance.label,
};

SyllabusResponse _$SyllabusResponseFromJson(Map<String, dynamic> json) =>
    SyllabusResponse(
      courseContent:
          (json['course_content'] as List<dynamic>?)
              ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SyllabusResponseToJson(SyllabusResponse instance) =>
    <String, dynamic>{'course_content': instance.courseContent};

SingleCourseInfo _$SingleCourseInfoFromJson(Map<String, dynamic> json) =>
    SingleCourseInfo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      aboutCourse: json['about_course'] as String? ?? '',
      description:
          (json['description'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      shortDescription: json['short_description'] as String? ?? '',
      authors:
          (json['authors'] as List<dynamic>?)
              ?.map((e) => Authors.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      willLearn:
          (json['what_will_learn'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      co_authors:
          (json['co_authors'] as List<dynamic>?)
              ?.map((e) => Authors.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      showPrice: json['show_price'] as bool? ?? false,
      thumbnail: json['cover_image'] == null
          ? null
          : MediaDTO.fromJson(json['cover_image'] as Map<String, dynamic>),
      previewVideo: json['preview_video'] == null
          ? null
          : MediaDTO.fromJson(json['preview_video'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      is_favorite: json['is_favorite'] as bool? ?? false,
      is_archived: json['is_archived'] as bool? ?? false,
      type: json['type'] == null
          ? null
          : CourseType.fromJson(json['type'] as Map<String, dynamic>),
      createdDate: (json['created_date'] as num?)?.toInt(),
      price: json['price'] as String? ?? '',
      updatedDate: (json['updated_date'] as num?)?.toInt(),
      courseStatus: json['course_status'] == null
          ? null
          : LabelValueResponse.fromJson(
              json['course_status'] as Map<String, dynamic>,
            ),
      file: json['file'] == null
          ? null
          : MediaDTO.fromJson(json['file'] as Map<String, dynamic>),
      language: json['language'] == null
          ? null
          : LanguageLevel.fromJson(json['language'] as Map<String, dynamic>),
      level: json['level'] == null
          ? null
          : LanguageLevel.fromJson(json['level'] as Map<String, dynamic>),
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map(
                (e) =>
                    LabelValueAsIntResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      coAuthorIds:
          (json['co_author_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      status: _readStatusObject(json, 'status') == null
          ? null
          : Status.fromJson(
              _readStatusObject(json, 'status') as Map<String, dynamic>,
            ),
      learnersCount:
          (_readEnrollmentsCount(json, 'learnersCount') as num?)?.toInt() ?? 0,
      syllabus: json['syllabus'] == null
          ? null
          : SyllabusResponse.fromJson(json['syllabus'] as Map<String, dynamic>),
      progress: (json['progress'] as num?)?.toInt(),
      published: json['published'] as bool?,
      canPublish: json['can_publish'] as bool?,
      completionTime: json['time_to_complete'] as String? ?? '-- || --',
      chapters:
          (json['chapters'] as List<dynamic>?)
              ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentlyActive: json['current_active'] == null
          ? null
          : CurrentlyActive.fromJson(
              json['current_active'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SingleCourseInfoToJson(SingleCourseInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'about_course': instance.aboutCourse,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'authors': instance.authors,
      'what_will_learn': instance.willLearn,
      'co_authors': instance.co_authors,
      'cover_image': instance.thumbnail,
      'preview_video': instance.previewVideo,
      'category': instance.category,
      'is_favorite': instance.is_favorite,
      'show_price': instance.showPrice,
      'is_archived': instance.is_archived,
      'type': instance.type,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'course_status': instance.courseStatus,
      'file': instance.file,
      'language': instance.language,
      'level': instance.level,
      'skills': instance.skills,
      'co_author_ids': instance.coAuthorIds,
      'status': instance.status,
      'learnersCount': instance.learnersCount,
      'syllabus': instance.syllabus,
      'progress': instance.progress,
      'published': instance.published,
      'can_publish': instance.canPublish,
      'time_to_complete': instance.completionTime,
      'price': instance.price,
      'chapters': instance.chapters,
      'current_active': instance.currentlyActive,
    };

LabelValueAsIntResponse _$LabelValueAsIntResponseFromJson(
  Map<String, dynamic> json,
) => LabelValueAsIntResponse(
  label: json['label'] as String? ?? '',
  value: (json['value'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LabelValueAsIntResponseToJson(
  LabelValueAsIntResponse instance,
) => <String, dynamic>{'label': instance.label, 'value': instance.value};

CourseShortInfo _$CourseShortInfoFromJson(Map<String, dynamic> json) =>
    CourseShortInfo(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description:
          (json['description'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      short_description: json['short_description'] as String? ?? '',
      authors:
          (json['authors'] as List<dynamic>?)
              ?.map((e) => Authors.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      co_authors:
          (json['co_authors'] as List<dynamic>?)
              ?.map((e) => Authors.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      showPrice: json['show_price'] as bool? ?? false,
      thumbnail: json['cover_image'] == null
          ? null
          : MediaDTO.fromJson(json['cover_image'] as Map<String, dynamic>),
      previewVideo: json['preview_video'] == null
          ? null
          : MediaDTO.fromJson(json['preview_video'] as Map<String, dynamic>),
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      is_favorite: json['is_favorite'] as bool? ?? false,
      is_archived: json['is_archived'] as bool? ?? false,
      type: json['type'] == null
          ? null
          : CourseType.fromJson(json['type'] as Map<String, dynamic>),
      courseStatus: json['course_status'] == null
          ? null
          : LabelValueResponse.fromJson(
              json['course_status'] as Map<String, dynamic>,
            ),
      file: json['file'] == null
          ? null
          : MediaDTO.fromJson(json['file'] as Map<String, dynamic>),
      language: json['language'] as String? ?? '',
      level: json['level'] as String? ?? '',
      willLearn: (json['what_will_learn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as String? ?? '',
      coAuthorIds: (json['co_author_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      status: json['status'] as String? ?? '',
      progess: (json['overall_progress'] as num?)?.toInt() ?? 0,
      rating: json['rating'] as String? ?? '',
      learnersCount: (json['learners_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CourseShortInfoToJson(CourseShortInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'short_description': instance.short_description,
      'authors': instance.authors,
      'co_authors': instance.co_authors,
      'cover_image': instance.thumbnail,
      'preview_video': instance.previewVideo,
      'category': instance.category,
      'is_favorite': instance.is_favorite,
      'show_price': instance.showPrice,
      'is_archived': instance.is_archived,
      'type': instance.type,
      'course_status': instance.courseStatus,
      'file': instance.file,
      'language': instance.language,
      'level': instance.level,
      'what_will_learn': instance.willLearn,
      'co_author_ids': instance.coAuthorIds,
      'status': instance.status,
      'price': instance.price,
      'overall_progress': instance.progess,
      'learners_count': instance.learnersCount,
      'rating': instance.rating,
    };

CurrentlyActive _$CurrentlyActiveFromJson(Map<String, dynamic> json) =>
    CurrentlyActive(
      chapterID: (json['chapter_id'] as num?)?.toInt() ?? 0,
      topicID: (json['topic_id'] as num?)?.toInt() ?? 0,
      stepID: (json['step_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CurrentlyActiveToJson(CurrentlyActive instance) =>
    <String, dynamic>{
      'chapter_id': instance.chapterID,
      'topic_id': instance.topicID,
      'step_id': instance.stepID,
    };

MakeCourseFavoriteRequest _$MakeCourseFavoriteRequestFromJson(
  Map<String, dynamic> json,
) => MakeCourseFavoriteRequest(
  courseID: (json['course_id'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MakeCourseFavoriteRequestToJson(
  MakeCourseFavoriteRequest instance,
) => <String, dynamic>{'course_id': instance.courseID};
