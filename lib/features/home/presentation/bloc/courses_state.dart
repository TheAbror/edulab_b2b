part of 'courses_bloc.dart';

class CoursesState extends Equatable {
  final CourseShortInfo fullCourseInfo;
  final List<CategoryModel> categories;
  final List<CourseShortInfo> coursesAll;
  final List<CourseShortInfo> currentCourse;
  final List<CourseShortInfo> courseByCategory;
  final HomeCoursesResponse homeCourses;
  final CourseEnrollmentResponse enrollmentResponse;
  final String enrollmentStatus;

  //
  final List<int> expandedSubcategoryIndexes;
  final BlocProgress blocProgress;
  final String failureMessage;
  final bool isEnrolled;

  const CoursesState({
    required this.fullCourseInfo,
    required this.coursesAll,
    required this.currentCourse,
    required this.courseByCategory,
    required this.homeCourses,
    required this.enrollmentResponse,
    required this.enrollmentStatus,

    required this.categories,
    required this.expandedSubcategoryIndexes,
    required this.blocProgress,
    required this.failureMessage,
    required this.isEnrolled,
  });

  factory CoursesState.initial() {
    return CoursesState(
      homeCourses: HomeCoursesResponse(content: []),

      fullCourseInfo: CourseShortInfo(
        rating: '',
        id: 0,
        title: '',
        progess: 0,
        description: [],
        short_description: '',
        category: CategoryModel(
          id: 0,
          title: '',
        ),
        learnersCount: 0,
        co_authors: [],
        authors: [
          Authors(
            userId: 0,
            about: '',
            id: 0,
            courseCount: 0,
            firstname: '',
            lastname: '',
            jobPosition: '',
            avatar: MediaDTO(
              original_name: '',
              src: '',
              file_size: 0,
              original_url: '',
              thumb_url: '',
              url: '',
              extension: '',
            ),
          ),
        ],
        thumbnail: MediaDTO(
          original_name: '',
          src: '',
          file_size: 0,
          original_url: '',
          thumb_url: '',
          url: '',
          extension: '',
        ),
      ),
      enrollmentResponse: CourseEnrollmentResponse(
        id: 0,
        status: '',
        managerStatus: '',
      ),
      enrollmentStatus: '',
      coursesAll: const [],
      currentCourse: const [],
      courseByCategory: const [],
      categories: const [],
      expandedSubcategoryIndexes: const [],
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      isEnrolled: false,
    );
  }

  CoursesState copyWith({
    CourseShortInfo? fullCourseInfo,
    List<CourseShortInfo>? coursesAll,
    List<CourseShortInfo>? currentCourse,
    List<CourseShortInfo>? courseByCategory,
    List<CourseShortInfo>? shortCourseInfo,
    List<CategoryModel>? categories,
    List<int>? expandedSubcategoryIndexes,
    BlocProgress? blocProgress,
    BlocProgress? singleCourseBlocProgress,
    HomeCoursesResponse? homeCourses,
    CourseEnrollmentResponse? enrollmentResponse,
    String? enrollmentStatus,

    String? failureMessage,
    bool? isEnrolled,
  }) {
    return CoursesState(
      homeCourses: homeCourses ?? this.homeCourses,

      fullCourseInfo: fullCourseInfo ?? this.fullCourseInfo,
      coursesAll: coursesAll ?? this.coursesAll,
      currentCourse: currentCourse ?? this.currentCourse,
      courseByCategory: courseByCategory ?? this.courseByCategory,
      categories: categories ?? this.categories,
      expandedSubcategoryIndexes:
          expandedSubcategoryIndexes ?? this.expandedSubcategoryIndexes,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      enrollmentResponse: enrollmentResponse ?? this.enrollmentResponse,
      enrollmentStatus: enrollmentStatus ?? this.enrollmentStatus,
    );
  }

  @override
  List<Object?> get props => [
    fullCourseInfo,
    coursesAll,
    currentCourse,
    courseByCategory,
    homeCourses,

    categories,
    expandedSubcategoryIndexes,
    blocProgress,
    failureMessage,
    isEnrolled,
    enrollmentResponse,
    enrollmentStatus,
  ];
}
