part of 'learning_tab_bloc.dart';

class LearningPageState extends Equatable {
  final bool isExpanded;
  final int currentTabIndex;
  final int materialsTabIndex;
  final SingleCourseInfo resumedCourse;
  final BlocProgress blocProgress;
  final String failureMessage;
  final int chapterID;
  final int topicID;
  final int stepID;

  const LearningPageState({
    required this.isExpanded,
    required this.currentTabIndex,
    required this.materialsTabIndex,
    required this.resumedCourse,
    required this.blocProgress,
    required this.failureMessage,
    required this.chapterID,
    required this.topicID,
    required this.stepID,
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
        skills: [],
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
      materialsTabIndex: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',

      chapterID: 0,
      topicID: 0,
      stepID: 0,
    );
  }

  LearningPageState copyWith({
    bool? isExpanded,
    int? currentTabIndex,
    int? materialsTabIndex,
    SingleCourseInfo? resumedCourse,
    BlocProgress? blocProgress,
    String? failureMessage,
    int? chapterID,
    int? topicID,
    int? stepID,
  }) {
    return LearningPageState(
      isExpanded: isExpanded ?? this.isExpanded,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      materialsTabIndex: materialsTabIndex ?? this.materialsTabIndex,
      resumedCourse: resumedCourse ?? this.resumedCourse,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      chapterID: chapterID ?? this.chapterID,
      topicID: topicID ?? this.topicID,
      stepID: stepID ?? this.stepID,
    );
  }

  @override
  List<Object?> get props => [
    isExpanded,
    currentTabIndex,
    materialsTabIndex,
    resumedCourse,
    blocProgress,
    failureMessage,
    chapterID,
    topicID,
    stepID,
  ];
}
