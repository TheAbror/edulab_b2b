part of 'courses_bloc.dart';

class CoursesState extends Equatable {
  final CourseShortInfo fullCourseInfo;
  final List<CategoryModel> categories;
  final List<CourseShortInfo> coursesAll;
  final List<CourseShortInfo> currentCourse;
  final List<CourseShortInfo> courseByCategory;
  //
  final List<int> expandedSubcategoryIndexes;
  final BlocProgress blocProgress;
  final String failureMessage;

  const CoursesState({
    required this.fullCourseInfo,
    required this.coursesAll,
    required this.currentCourse,
    required this.courseByCategory,
    required this.categories,
    required this.expandedSubcategoryIndexes,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory CoursesState.initial() {
    return CoursesState(
      fullCourseInfo: CourseShortInfo(
        id: 0,
        title: '',
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
      coursesAll: const [],
      currentCourse: const [],
      courseByCategory: const [],
      categories: const [],
      expandedSubcategoryIndexes: const [],
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
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
    String? failureMessage,
  }) {
    return CoursesState(
      fullCourseInfo: fullCourseInfo ?? this.fullCourseInfo,
      coursesAll: coursesAll ?? this.coursesAll,
      currentCourse: currentCourse ?? this.currentCourse,
      courseByCategory: courseByCategory ?? this.courseByCategory,
      categories: categories ?? this.categories,
      expandedSubcategoryIndexes:
          expandedSubcategoryIndexes ?? this.expandedSubcategoryIndexes,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullCourseInfo,
        coursesAll,
        currentCourse,
        courseByCategory,
        categories,
        expandedSubcategoryIndexes,
        blocProgress,
        failureMessage,
      ];
}
