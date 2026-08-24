part of 'courses_bloc.dart';

class CoursesState extends Equatable {
  final CourseShortInfo fullCourseInfo;
  final List<CourseShortInfo> coursesAll;
  final List<CourseShortInfo> currentCourse;
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
    required this.enrollmentResponse,
    required this.enrollmentStatus,
    required this.expandedSubcategoryIndexes,
    required this.blocProgress,
    required this.failureMessage,
    required this.isEnrolled,
  });

  factory CoursesState.initial() {
    return CoursesState(
      fullCourseInfo: CourseShortInfo.initial(),
      enrollmentResponse: CourseEnrollmentResponse.initial(),
      enrollmentStatus: '',
      coursesAll: const [],
      currentCourse: const [],
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
    List<CourseShortInfo>? shortCourseInfo,
    List<int>? expandedSubcategoryIndexes,
    BlocProgress? blocProgress,
    BlocProgress? singleCourseBlocProgress,
    CourseEnrollmentResponse? enrollmentResponse,
    String? enrollmentStatus,

    String? failureMessage,
    bool? isEnrolled,
  }) {
    return CoursesState(
      fullCourseInfo: fullCourseInfo ?? this.fullCourseInfo,
      coursesAll: coursesAll ?? this.coursesAll,
      currentCourse: currentCourse ?? this.currentCourse,
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
    expandedSubcategoryIndexes,
    blocProgress,
    failureMessage,
    isEnrolled,
    enrollmentResponse,
    enrollmentStatus,
  ];
}
