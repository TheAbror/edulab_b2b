part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<QuizRequest> quizRequests;
  final List<QuizResponse>? response;
  //
  final int correctAnswersCount;
  final int overallAnswersCount;
  final int correctnessPercentage;
  final bool isAllSelected;
  final int quizzesCount;
  final BlocProgress blocProgress;
  final String failureMessage;

  const QuizState({
    required this.quizRequests,
    required this.response,
    required this.correctAnswersCount,
    required this.overallAnswersCount,
    required this.correctnessPercentage,
    required this.isAllSelected,
    required this.quizzesCount,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory QuizState.initial() {
    return const QuizState(
      quizRequests: [],
      response: [],
      correctAnswersCount: 0,
      overallAnswersCount: 0,
      correctnessPercentage: 0,
      isAllSelected: false,
      quizzesCount: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  QuizState copyWith({
    List<QuizRequest>? quizRequests,
    List<QuizResponse>? response,
    int? correctAnswersCount,
    int? overallAnswersCount,
    int? correctnessPercentage,
    bool? isAllSelected,
    int? quizzesCount,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return QuizState(
      quizRequests: quizRequests ?? this.quizRequests,
      response: response ?? this.response,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      overallAnswersCount: overallAnswersCount ?? this.overallAnswersCount,
      correctnessPercentage:
          correctnessPercentage ?? this.correctnessPercentage,
      isAllSelected: isAllSelected ?? this.isAllSelected,
      quizzesCount: quizzesCount ?? this.quizzesCount,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    quizRequests,
    response,
    correctAnswersCount,
    overallAnswersCount,
    correctnessPercentage,
    isAllSelected,
    quizzesCount,
    blocProgress,
    failureMessage,
  ];
}
