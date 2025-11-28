part of 'learning_tab_bloc.dart';

class LearningTabState extends Equatable {
  final int tabIndex;
  final List<CourseShortInfo> inProgress;
  final List<CourseShortInfo> completed;
  final List<CourseShortInfo> favorites;
  final LearningTabStatisticsResponse statistics;
  final BlocProgress blocProgress;
  final String failureMessage;

  const LearningTabState({
    required this.tabIndex,
    required this.inProgress,
    required this.completed,
    required this.favorites,
    required this.statistics,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory LearningTabState.initial() {
    return LearningTabState(
      tabIndex: 0,
      inProgress: const [],
      completed: const [],
      favorites: const [],
      statistics: LearningTabStatisticsResponse(
        streak: StreakResponse(
          days: StreakDaysResponse(
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false,
            sunday: false,
          ),
          label: '',
        ),
        totalTimeLearning: '',
        inProgress: '',
        completed: '',
      ),
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  LearningTabState copyWith({
    int? tabIndex,
    List<CourseShortInfo>? inProgress,
    List<CourseShortInfo>? completed,
    List<CourseShortInfo>? favorites,
    LearningTabStatisticsResponse? statistics,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return LearningTabState(
      tabIndex: tabIndex ?? this.tabIndex,
      inProgress: inProgress ?? this.inProgress,
      completed: completed ?? this.completed,
      favorites: favorites ?? this.favorites,
      statistics: statistics ?? this.statistics,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        tabIndex,
        inProgress,
        completed,
        favorites,
        statistics,
        blocProgress,
        failureMessage,
      ];
}
