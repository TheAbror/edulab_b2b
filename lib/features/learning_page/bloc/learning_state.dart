part of 'learning_bloc.dart';

class LearningState extends Equatable {
  final int appbarTabIndex;
  final bool isExpanded;
  final int materialsTabIndex;
  final SingleCourseInfo resumedCourse;
  final BlocProgress blocProgress;
  final String failureMessage;
  final int chapterID;
  final int topicID;
  final int stepID;
  final int courseID;
  final ChapterModel chapter;
  final TopicModel topic;
  final StepModel step;
  final List<StepModel> allSteps;

  const LearningState({
    required this.appbarTabIndex,
    required this.isExpanded,
    required this.materialsTabIndex,
    required this.resumedCourse,
    required this.blocProgress,
    required this.failureMessage,
    required this.chapterID,
    required this.topicID,
    required this.stepID,
    required this.courseID,
    required this.chapter,
    required this.topic,
    required this.step,
    required this.allSteps,
  });

  factory LearningState.initial() {
    return LearningState(
      appbarTabIndex: 0,
      isExpanded: false,
      resumedCourse: SingleCourseInfo.initial(),
      materialsTabIndex: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      chapterID: 0,
      topicID: 0,
      stepID: 0,
      courseID: 0,
      chapter: ChapterModel.initial(),
      topic: TopicModel.initial(),
      step: StepModel.initial(),
      allSteps: [],
    );
  }

  LearningState copyWith({
    int? appbarTabIndex,
    bool? isExpanded,
    int? materialsTabIndex,
    SingleCourseInfo? resumedCourse,
    BlocProgress? blocProgress,
    String? failureMessage,
    int? chapterID,
    int? topicID,
    int? stepID,
    int? courseID,
    ChapterModel? chapter,
    TopicModel? topic,
    StepModel? step,
    List<StepModel>? allSteps,
  }) {
    return LearningState(
      appbarTabIndex: appbarTabIndex ?? this.appbarTabIndex,
      isExpanded: isExpanded ?? this.isExpanded,
      materialsTabIndex: materialsTabIndex ?? this.materialsTabIndex,
      resumedCourse: resumedCourse ?? this.resumedCourse,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      chapterID: chapterID ?? this.chapterID,
      topicID: topicID ?? this.topicID,
      stepID: stepID ?? this.stepID,
      courseID: courseID ?? this.courseID,
      chapter: chapter ?? this.chapter,
      topic: topic ?? this.topic,
      step: step ?? this.step,
      allSteps: allSteps ?? this.allSteps,
    );
  }

  @override
  List<Object?> get props => [
    appbarTabIndex,
    isExpanded,
    materialsTabIndex,
    resumedCourse,
    blocProgress,
    failureMessage,
    chapterID,
    topicID,
    stepID,
    courseID,
    chapter,
    topic,
    step,
    allSteps,
  ];
}
