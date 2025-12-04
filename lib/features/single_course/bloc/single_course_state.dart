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
  });

  factory SingleCourseState.initial() {
    return SingleCourseState(
      singleCourse: SingleCourseInfo(
        id: 0,
        title: '',
        description: [],
        shortDescription: '',
        co_authors: [],
        prerequisites: [],
        skills: [],
        coAuthorIds: [],
        chapters: [],
        category: CategoryModel(
          id: 0,
          title: '',
        ),

        learnersCount: 0,
        willLearn: [],
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
      ),

      singleCourseChapters: [],
      courseMaterialsAreHidden: false,
      materialsMoreThan3: true,
      isDescriptionHidden: true,
      isFavorite: false,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      lastStoppedStep: CurrentlyActive(chapterID: 0, topicID: 0, stepID: 0),
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
  ];
}
