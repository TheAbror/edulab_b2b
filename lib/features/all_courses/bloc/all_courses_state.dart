part of 'all_courses_bloc.dart';

class AllCoursesState extends Equatable {
  final List<CourseShortInfo> allCourses;
  final List<CourseShortInfo> coursesByCategory;
  final BlocProgress blocProgress;
  final String failureMessage;

  const AllCoursesState({
    required this.allCourses,
    required this.coursesByCategory,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory AllCoursesState.initial() {
    return AllCoursesState(
      allCourses: const [],
      coursesByCategory: const [],
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  AllCoursesState copyWith({
    List<CourseShortInfo>? allCourses,
    List<CourseShortInfo>? coursesByCategory,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return AllCoursesState(
      allCourses: allCourses ?? this.allCourses,
      coursesByCategory: coursesByCategory ?? this.coursesByCategory,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    allCourses,
    coursesByCategory,
    blocProgress,
    failureMessage,
  ];
}
