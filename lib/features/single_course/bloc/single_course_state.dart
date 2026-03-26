part of 'single_course_bloc.dart';

class SingleCourseState extends Equatable {
  final SingleCourseInfo singleCourse;
  final List<ChapterModel> singleCourseChapters;
  final bool courseMaterialsAreHidden;
  //when Show all button pressed, will show Hide button
  final bool materialsMoreThan3;
  final bool isDescriptionHidden;
  final bool isFavorite;
  final BlocProgress blocProgress;
  final String failureMessage;
  final CurrentlyActive? lastStoppedStep;
  final bool navigateToLearning;
  final int courseID;
  final bool isRequested;

  const SingleCourseState({
    required this.singleCourse,
    required this.singleCourseChapters,
    required this.courseMaterialsAreHidden,
    required this.materialsMoreThan3,
    required this.isDescriptionHidden,
    required this.isFavorite,
    required this.blocProgress,
    required this.failureMessage,
    required this.lastStoppedStep,
    required this.navigateToLearning,
    required this.courseID,
    required this.isRequested,
  });

  factory SingleCourseState.initial() {
    return SingleCourseState(
      singleCourse: SingleCourseInfo(
        id: 0,
        title: '',
        aboutCourse: '',
        description: [],
        willLearn: [],
        price: '',
        shortDescription: '',
        co_authors: [],
        skills: [],
        showPrice: false,
        coAuthorIds: [],
        chapters: [],
        category: CategoryModel(
          id: 0,
          title: '',
        ),

        learnersCount: 0,
        syllabus: SyllabusResponse(studyGoals: []),
        authors: [
          Authors(
            userId: 0,
            about: '',
            id: 0,
            courseCount: 0,
            firstname: '',
            lastname: '',
            jobPosition: '',
            avatar: MediaDTO.initial(),
          ),
        ],
      ),

      singleCourseChapters: [],
      courseMaterialsAreHidden: false,
      materialsMoreThan3: true,
      isDescriptionHidden: true,
      isFavorite: false,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      lastStoppedStep: CurrentlyActive(chapterID: 0, topicID: 0, stepID: 0),
      navigateToLearning: false,
      courseID: 0,
      isRequested: false,
    );
  }

  SingleCourseState copyWith({
    SingleCourseInfo? singleCourse,
    List<ChapterModel>? singleCourseChapters,
    bool? courseMaterialsAreHidden,
    bool? materialsMoreThan3,
    bool? isDescriptionHidden,
    bool? isFavorite,
    BlocProgress? blocProgress,
    String? failureMessage,
    CurrentlyActive? lastStoppedStep,
    bool? navigateToLearning,
    int? courseID,
    bool? isRequested,
  }) {
    return SingleCourseState(
      singleCourse: singleCourse ?? this.singleCourse,
      courseMaterialsAreHidden:
          courseMaterialsAreHidden ?? this.courseMaterialsAreHidden,
      singleCourseChapters: singleCourseChapters ?? this.singleCourseChapters,
      materialsMoreThan3: materialsMoreThan3 ?? this.materialsMoreThan3,
      isDescriptionHidden: isDescriptionHidden ?? this.isDescriptionHidden,
      isFavorite: isFavorite ?? this.isFavorite,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      lastStoppedStep: lastStoppedStep ?? this.lastStoppedStep,
      navigateToLearning: navigateToLearning ?? this.navigateToLearning,
      courseID: courseID ?? this.courseID,
      isRequested: isRequested ?? this.isRequested,
    );
  }

  @override
  List<Object?> get props => [
    singleCourse,
    singleCourseChapters,
    courseMaterialsAreHidden,
    materialsMoreThan3,
    isDescriptionHidden,
    isFavorite,
    blocProgress,
    failureMessage,
    lastStoppedStep,
    navigateToLearning,
    courseID,
    isRequested,
  ];
}
