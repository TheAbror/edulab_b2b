part of 'single_course_bloc.dart';

class SingleCourseState extends Equatable {
  final SingleCourseInfo fullCourseInfo;
  final bool courseMaterialsAreHidden;
  //when Show all button pressed, will show Hide button
  final bool materialsMoreThan3;
  final bool isDescriptionHidden;
  final bool isFavorite;
  final BlocProgress blocProgress;
  final String failureMessage;

  const SingleCourseState({
    required this.fullCourseInfo,
    required this.courseMaterialsAreHidden,
    required this.materialsMoreThan3,
    required this.isDescriptionHidden,
    required this.isFavorite,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory SingleCourseState.initial() {
    return SingleCourseState(
      fullCourseInfo: SingleCourseInfo(
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
      courseMaterialsAreHidden: false,
      materialsMoreThan3: true,
      isDescriptionHidden: true,
      isFavorite: false,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  SingleCourseState copyWith({
    SingleCourseInfo? fullCourseInfo,
    bool? courseMaterialsAreHidden,
    bool? materialsMoreThan3,
    bool? isDescriptionHidden,
    bool? isFavorite,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return SingleCourseState(
      fullCourseInfo: fullCourseInfo ?? this.fullCourseInfo,
      courseMaterialsAreHidden:
          courseMaterialsAreHidden ?? this.courseMaterialsAreHidden,
      materialsMoreThan3: materialsMoreThan3 ?? this.materialsMoreThan3,
      isDescriptionHidden: isDescriptionHidden ?? this.isDescriptionHidden,
      isFavorite: isFavorite ?? this.isFavorite,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullCourseInfo,
        courseMaterialsAreHidden,
        materialsMoreThan3,
        isDescriptionHidden,
        isFavorite,
        blocProgress,
        failureMessage,
      ];
}
