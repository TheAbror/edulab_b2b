part of 'learning_tab_bloc.dart';

class LearningPageState extends Equatable {
  final bool isExpanded;
  final int currentTabIndex;
  final SingleCourseInfo resumedCourse;
  final BlocProgress blocProgress;
  final String failureMessage;

  const LearningPageState({
    required this.isExpanded,
    required this.currentTabIndex,
    required this.resumedCourse,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory LearningPageState.initial() {
    return LearningPageState(
      isExpanded: false,
      resumedCourse: SingleCourseInfo(
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
      currentTabIndex: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  LearningPageState copyWith({
    bool? isExpanded,
    int? currentTabIndex,
    SingleCourseInfo? resumedCourse,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return LearningPageState(
      isExpanded: isExpanded ?? this.isExpanded,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      resumedCourse: resumedCourse ?? this.resumedCourse,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        isExpanded,
        currentTabIndex,
        resumedCourse,
        blocProgress,
        failureMessage,
      ];
}
