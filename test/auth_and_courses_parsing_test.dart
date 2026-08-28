import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:edulab_b2b/features/auth/data/models/auth_models.dart';
import 'package:edulab_b2b/features/home/data/datasources/models/courses_models.dart';
import 'package:edulab_b2b/features/home/data/datasources/models/quiz_response.dart';

// Real payloads captured from the live backend
// (https://944b-…ngrok-free.app/edulab/api/v1/core/mobile/…).
void main() {
  test('signin/step_two AuthResponseDTO parses', () {
    final json = jsonDecode('''
    {
      "token": "eyJhbGciOiJIUzI1NiJ9.payload.sig",
      "sign_up_required": false,
      "user_info": {
        "id": 14,
        "username": "1001",
        "firstname": "Anna",
        "lastname": "Kareemoffa",
        "roles": ["INSTRUCTOR"],
        "roles_map": {"INSTRUCTOR": "INSTRUCTOR"},
        "current_role": null,
        "required_actions": [],
        "email": "annaWatson@gmail.com",
        "status": "ACTIVE",
        "account_type": "INSTRUCTOR",
        "account_type_str": "Instructor",
        "profile_photo": null,
        "selected_theme": null,
        "selected_locale": null,
        "phone": "998000000002",
        "about_me": null,
        "organization_id": 2,
        "organization_settings": null,
        "job_position": null,
        "department": null
      }
    }
    ''') as Map<String, dynamic>;

    final res = AuthResponse.fromJson(json);

    expect(res.signUpRequired, false);
    expect(res.token, isNotEmpty);
    expect(res.userInfo!.id, 14);
    expect(res.userInfo!.username, '1001');
    expect(res.userInfo!.roles, ['INSTRUCTOR']);
    expect(res.userInfo!.requiredActions, isEmpty);
    expect(res.userInfo!.accountType, 'INSTRUCTOR');
    expect(res.userInfo!.email, 'annaWatson@gmail.com');
    expect(res.userInfo!.phone, '998000000002');
    // null on this account
    expect(res.userInfo!.department, anyOf(isNull, isEmpty));
    expect(res.userInfo!.jobPosition, anyOf(isNull, isEmpty));
  });

  test('user_info with department and job_position parses', () {
    final json = jsonDecode('''
    {
      "sign_up_required": false,
      "token": "t",
      "user_info": {
        "id": 7, "username": "EMP-2048", "firstname": "Sarah", "lastname": "Mitchell",
        "roles": ["LEARNER"], "required_actions": [],
        "status": "ACTIVE", "account_type": "LEARNER", "account_type_str": "Learner",
        "profile_photo": null,
        "email": "sarah.mitchell@company.com",
        "phone": "998952489012",
        "department": "Marketing Department",
        "job_position": "Senior Marketing Specialist"
      }
    }
    ''') as Map<String, dynamic>;

    final user = AuthResponse.fromJson(json).userInfo!;

    expect(user.username, 'EMP-2048');
    expect(user.email, 'sarah.mitchell@company.com');
    expect(user.phone, '998952489012');
    expect(user.department, 'Marketing Department');
    expect(user.jobPosition, 'Senior Marketing Specialist');
  });

  test('signin/step_two with populated required_actions parses', () {
    final json = jsonDecode('''
    {
      "sign_up_required": false,
      "token": "t",
      "user_info": {
        "id": 1, "username": "u", "firstname": "a", "lastname": "b",
        "roles": ["LEARNER"], "required_actions": ["VERIFY_EMAIL", "UPDATE_PASSWORD"],
        "status": "ACTIVE", "account_type": "LEARNER", "account_type_str": "Learner",
        "profile_photo": null
      }
    }
    ''') as Map<String, dynamic>;

    final res = AuthResponse.fromJson(json);
    expect(res.userInfo!.requiredActions, ['VERIFY_EMAIL', 'UPDATE_PASSWORD']);
  });

  test('course/all list parses into List<CourseShortInfo>', () {
    final list = jsonDecode(_courseAllPayload) as List<dynamic>;

    final courses = list
        .map((e) => CourseShortInfo.fromJson(e as Map<String, dynamic>))
        .toList();

    expect(courses, hasLength(4));
    expect(courses.first.id, 2800);
    expect(courses.first.title, contains('B1 - B2'));
    expect(courses.first.category.title, 'IT');
    expect(courses.first.thumbnail!.url, contains('b1b2'));
    // language/level come back null on this endpoint
    expect(courses.first.language, anyOf(isNull, isEmpty));
    expect(courses.first.rating, '4.6');
  });

  group('course/{id} -> SingleCourseInfo', () {
    test('full payload parses, including syllabus and authors', () {
      final json = jsonDecode(_courseByIdPayload) as Map<String, dynamic>;

      final course = SingleCourseInfo.fromJson(json);

      expect(course.id, 2800);
      expect(course.title, contains('B1 - B2'));
      // snake_case keys that used to be mismapped
      expect(course.shortDescription, 'Short intro to the course');
      expect(course.completionTime, '800'); // was read from "completion_time"
      expect(course.canPublish, true); // was read from "canPublish"
      expect(course.learnersCount, 137); // "enrollments_count" on this endpoint

      expect(course.aboutCourse, contains('<p>'));
      expect(course.willLearn, isNotEmpty);
      expect(course.description, ['First line', 'Second line']);
      expect(course.showPrice, true);
      expect(course.price, '250 000');
      expect(course.category?.title, 'IT');
      expect(course.type?.value, 'BASIC');
      expect(course.language?.label, 'English');
      expect(course.level?.label, 'Intermediate');
      expect(course.skills.map((s) => s.label), contains('Speaking'));

      // authors
      expect(course.authors, hasLength(1));
      expect(course.authors.first.firstname, 'Anna');
      expect(course.authors.first.courseCount, 4);
      expect(course.authors.first.avatar?.url, contains('anna'));
      expect(course.co_authors, isEmpty);

      // syllabus / chapters / topics / steps
      final content = course.syllabus!.courseContent!;
      expect(content, hasLength(2));
      expect(content.first.title, 'Chapter 1');
      expect(content.first.topics, hasLength(1));
      expect(content.first.topics.first.title, 'Topic 1.1');
      expect(content.first.topics.first.steps, hasLength(2));
      expect(content.first.topics.first.steps.first.title, 'Intro video');

      // top-level chapters list is also populated
      expect(course.chapters, hasLength(2));
    });

    test('tolerates string "status", missing enrollments_count, partial media',
        () {
      final json = jsonDecode(_courseByIdSparsePayload) as Map<String, dynamic>;

      final course = SingleCourseInfo.fromJson(json);

      expect(course.id, 916);
      expect(course.status, isNull); // "status": "PUBLISHED" (string) is ignored
      expect(course.learnersCount, 5); // falls back to "learners_count"
      expect(course.completionTime, '-- || --'); // absent -> default
      // partial media object (only "url") must not throw on the missing fields
      expect(course.previewVideo!.url, 'http://h/');
      expect(course.previewVideo!.src, '');
      expect(course.previewVideo!.fileSize, 0);
      expect(course.syllabus?.courseContent, anyOf(isNull, isEmpty));
    });

    test('syllabus steps with resources, questions and answered quizzes parse',
        () {
      final json = jsonDecode(_courseByIdDeepPayload) as Map<String, dynamic>;

      final course = SingleCourseInfo.fromJson(json);

      final topic = course.syllabus!.courseContent!.first.topics.first;
      expect(topic.resources, hasLength(1));
      expect(topic.resources.first.url, 'http://h/handout.pdf');

      final quizStep = topic.steps.firstWhere((s) => s.id == 2001);
      // unknown status string -> falls back instead of throwing
      expect(quizStep.status, StepItemStatus.closed);
      expect(quizStep.questions, hasLength(1));
      expect(quizStep.questions.first.options, hasLength(2));
      // questions_answers with object-shaped selected_options / value
      expect(quizStep.answers, hasLength(1));
      expect(quizStep.answers.first.selectedOptions, [55]);
      expect(quizStep.answers.first.options.first.value, isNull);
      expect(quizStep.answers.first.type, isNull);
    });
  });
}

const _courseByIdPayload = '''
{
  "id": 2800,
  "title": "Английский язык для продолжающих  (B1 - B2)",
  "about_course": "<p>Full description of the course</p>",
  "short_description": "Short intro to the course",
  "description": ["First line", "Second line"],
  "what_will_learn": ["Hold a conversation", "Write a formal email"],
  "authors": [
    {
      "id": 5, "user_id": 14, "firstname": "Anna", "lastname": "Karim",
      "job_position": "Senior Instructor", "about": "10 years of teaching",
      "course_count": 4,
      "avatar": {
        "src": "a/anna.png", "original_name": "anna.png", "extension": "png",
        "url": "http://h/anna.png", "file_size": 1024, "thumb_url": "http://h/anna.png",
        "original_url": "http://h/anna.png", "file_size_str": "1 KB"
      }
    }
  ],
  "co_authors": [],
  "can_publish": true,
  "published": true,
  "progress": 0,
  "rating": "4.6",
  "enrollments_count": 137,
  "time_to_complete": "800",
  "price": "250 000", "price_old": "300 000", "price_percent": "16",
  "showPrice": true, "show_price": true,
  "is_favorite": false, "is_archived": false,
  "category": {"id": 2, "title": "IT"},
  "course_status": {"label": "Published", "value": "PUBLISHED", "icon": null, "color": null},
  "type": {"value": "BASIC", "label": "Basic"},
  "language": {"label": "English", "value": 1},
  "level": {"label": "Intermediate", "value": 3},
  "skills": [{"label": "Speaking", "value": 1}, {"label": "Writing", "value": 2}],
  "cover_image": {
    "src": "x/b1b2.png", "original_name": "b1b2.png", "extension": "png",
    "url": "http://h/b1b2.png", "file_size": 4224, "thumb_url": "http://h/b1b2.png",
    "original_url": "http://h/b1b2.png", "file_size_str": "4.13 KB"
  },
  "preview_video": null,
  "file": null,
  "created_date": 1787309756039,
  "updated_date": 1787310021496,
  "xapi_course_url": null,
  "syllabus": {
    "study_goals": ["Reach B2"],
    "course_content": [
      {
        "id": 10, "title": "Chapter 1", "description": "Basics", "priority": 0,
        "topics": [
          {
            "id": 100, "title": "Topic 1.1", "description": "Greetings",
            "priority": 0, "course_id": 2800, "chapter_id": 10, "status": "ACTIVE",
            "resources": [],
            "steps": [
              {"id": 1000, "title": "Intro video", "type": "VIDEO", "priority": 0, "status": "ACTIVE"},
              {"id": 1001, "title": "Reading", "type": "TEXT", "priority": 1, "status": "CLOSED"}
            ]
          }
        ]
      },
      {
        "id": 11, "title": "Chapter 2", "description": "Advanced", "priority": 1,
        "topics": []
      }
    ]
  },
  "chapters": [
    {"id": 10, "title": "Chapter 1", "description": "Basics", "priority": 0, "topics": []},
    {"id": 11, "title": "Chapter 2", "description": "Advanced", "priority": 1, "topics": []}
  ],
  "current_active": {"chapter_id": 10, "topic_id": 100, "step_id": 1000}
}
''';

const _courseByIdSparsePayload = '''
{
  "id": 916, "title": "Node.js",
  "about_course": null, "short_description": null,
  "description": null, "what_will_learn": null,
  "authors": [], "co_authors": [], "co_author_ids": null,
  "category": {"id": 2, "title": "IT"},
  "type": {"value": "BASIC", "label": "Basic"},
  "language": null, "level": null,
  "status": "PUBLISHED",
  "learners_count": 5,
  "show_price": false,
  "preview_video": {"url": "http://h/"},
  "cover_image": null,
  "syllabus": null,
  "chapters": null
}
''';

// Exercises the deep syllabus shapes from the Springfox schema: topic resources,
// step questions, and answered quizzes (questions_answers) whose selected_options
// and option "value" come back as objects rather than scalars.
const _courseByIdDeepPayload = '''
{
  "id": 3001, "title": "Deep course",
  "authors": [], "co_authors": [],
  "category": {"id": 2, "title": "IT"},
  "type": {"value": "BASIC", "label": "Basic"},
  "language": null, "level": null,
  "show_price": false,
  "syllabus": {
    "course_content": [
      {
        "id": 20, "title": "Chapter A", "description": "", "priority": 0,
        "topics": [
          {
            "id": 200, "title": "Topic A.1", "description": "", "priority": 0,
            "status": "ACTIVE",
            "resources": [
              {"src": "r/handout.pdf", "original_name": "handout.pdf", "extension": "pdf",
               "url": "http://h/handout.pdf", "file_size": 2048, "thumb_url": "http://h/handout.pdf",
               "original_url": "http://h/handout.pdf", "file_size_str": "2 KB"}
            ],
            "steps": [
              {"id": 2000, "title": "Lesson", "type": "TEXT", "priority": 0, "status": "ACTIVE"},
              {
                "id": 2001, "title": "Quiz", "type": "QUIZ", "priority": 1, "status": "IN_PROGRESS",
                "questions": [
                  {
                    "id": 900, "text": "Pick one", "index": 0, "priority": 0,
                    "difficulty": "EASY", "status": "CORRECT",
                    "type": {"value": "SINGLE_CHOICE", "label": "Single choice", "icon": null, "color": null},
                    "options": [
                      {"id": 55, "text": "Right", "correct": true, "priority": 0},
                      {"id": 56, "text": "Wrong", "correct": false, "priority": 1}
                    ]
                  }
                ],
                "questions_answers": [
                  {
                    "id": 900, "number": 1, "index": 0, "priority": 0,
                    "text": "Pick one", "difficulty": "EASY", "status": "CORRECT",
                    "options": [
                      {"id": 55, "text": "Right", "value": {}},
                      {"id": 56, "text": "Wrong", "value": {}}
                    ],
                    "selected_options": [
                      {"id": 55, "text": "Right", "value": {}}
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  },
  "chapters": []
}
''';

const _courseAllPayload = '''
[
  {
    "id": 2800, "title": "Английский язык для продолжающих  (B1 - B2)",
    "short_description": null, "what_will_learn": null, "will_learn": null,
    "description": null, "about_course": "<p>text</p>",
    "authors": [], "co_authors": [], "co_author_ids": null,
    "category": {"id": 2, "title": "IT"},
    "course_status": {"label": "Published", "value": "PUBLISHED", "icon": null, "color": null},
    "type": {"value": "BASIC", "label": "Basic"},
    "language": null, "level": null, "file": null,
    "cover_image": {"src": "x/b1b2.png", "original_name": "b1b2.png", "extension": "png",
      "url": "http://h/b1b2.png", "file_size": 4224, "thumb_url": "http://h/b1b2.png",
      "original_url": "http://h/b1b2.png", "file_size_str": "4.13 KB"},
    "preview_video": {"src": "", "original_name": "no-name", "extension": "",
      "url": "http://h/", "file_size": 0, "thumb_url": "http://h/",
      "original_url": "http://h/", "file_size_str": "0 KB"},
    "price": null, "price_old": null, "show_price": false,
    "is_archived": null, "is_favorite": null,
    "status": "PUBLISHED", "rating": "4.6", "learners_count": 100,
    "enrolled_users": "11K", "time_to_complete": "800",
    "created_date": 1787309756039, "updated_date": 1787310021496,
    "xapi_course_url": null
  },
  {
    "id": 2550, "title": "Draft course",
    "authors": [], "co_authors": [], "co_author_ids": null,
    "category": {"id": 2, "title": "IT"},
    "course_status": {"label": "Draft", "value": "DRAFT", "icon": null, "color": null},
    "type": {"value": "BASIC", "label": "Basic"},
    "language": null, "level": null,
    "cover_image": {"src": "x.png", "original_name": "x.png", "extension": "png",
      "url": "http://h/x.png", "file_size": 6381, "thumb_url": "http://h/x.png",
      "original_url": "http://h/x.png", "file_size_str": "6.23 KB"},
    "preview_video": null,
    "rating": "", "learners_count": 0, "show_price": false, "status": "DRAFT"
  },
  {
    "id": 916, "title": "Node.js",
    "authors": [], "co_authors": [], "co_author_ids": null,
    "category": {"id": 2, "title": "IT"},
    "course_status": {"label": "Published", "value": "PUBLISHED", "icon": null, "color": null},
    "type": {"value": "BASIC", "label": "Basic"},
    "language": null, "level": null,
    "cover_image": {"src": "n.webp", "original_name": "n.webp", "extension": "webp",
      "url": "http://h/n.webp", "file_size": 40212, "thumb_url": "http://h/n.webp",
      "original_url": "http://h/n.webp", "file_size_str": "39.27 KB"},
    "preview_video": {"src": "v.mp4", "original_name": "v.mp4", "extension": "mp4",
      "url": "http://h/v.mp4", "file_size": 51793548, "thumb_url": "http://h/v.mp4",
      "original_url": "http://h/v.mp4", "file_size_str": "49.39 MB"},
    "rating": "", "learners_count": 0, "show_price": false, "status": "PUBLISHED"
  },
  {
    "id": 730, "title": "History",
    "authors": [], "co_authors": [], "co_author_ids": null,
    "category": {"id": 2, "title": "IT"},
    "course_status": {"label": "Published", "value": "PUBLISHED", "icon": null, "color": null},
    "type": {"value": "BASIC", "label": "Basic"},
    "language": null, "level": null,
    "cover_image": {"src": "m.jpg", "original_name": "m.jpg", "extension": "jpg",
      "url": "http://h/m.jpg", "file_size": 924430, "thumb_url": "http://h/m.jpg",
      "original_url": "http://h/m.jpg", "file_size_str": "902.76 KB"},
    "preview_video": null,
    "rating": "", "learners_count": 0, "show_price": false, "status": "PUBLISHED"
  }
]
''';
