part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final QuizRequest quizRequests;
  final List<NewQuizAnswers> answers;
  final List<String> answersIDS;
  final List<int> questionIDS;
  final QuizResultResponse? response;
  final bool resultsSubmitted;

  final double correctnessPercentage;
  final bool isAllSelected;
  final int quizzesCount;
  final BlocProgress blocProgress;
  final String failureMessage;

  const QuizState({
    required this.quizRequests,
    required this.answers,
    required this.answersIDS,
    required this.questionIDS,
    required this.response,
    required this.resultsSubmitted,
    required this.correctnessPercentage,
    required this.isAllSelected,
    required this.quizzesCount,
    required this.blocProgress,
    required this.failureMessage,
  });

  bool get passedTheQuiz =>
      response?.quizInfo.passed == true &&
      response?.quizInfo.scorePercentage != 0 &&
      resultsSubmitted;

  bool get failedTheQuiz =>
      response?.quizInfo.passed == false && resultsSubmitted;

  factory QuizState.initial() {
    return QuizState(
      quizRequests: QuizRequest.initial(),
      answers: [],
      answersIDS: [],
      questionIDS: [],
      response: QuizResultResponse.initial(),
      resultsSubmitted: false,
      correctnessPercentage: 0,
      isAllSelected: false,
      quizzesCount: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  QuizState copyWith({
    QuizRequest? quizRequests,
    List<NewQuizAnswers>? answers,
    List<String>? answersIDS,
    List<int>? questionIDS,
    QuizResultResponse? response,
    bool? resultsSubmitted,
    double? correctnessPercentage,
    bool? isAllSelected,
    int? quizzesCount,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return QuizState(
      quizRequests: quizRequests ?? this.quizRequests,
      answers: answers ?? this.answers,
      answersIDS: answersIDS ?? this.answersIDS,
      questionIDS: questionIDS ?? this.questionIDS,
      response: response ?? this.response,
      resultsSubmitted: resultsSubmitted ?? this.resultsSubmitted,
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
    answers,
    answersIDS,
    questionIDS,
    response,
    resultsSubmitted,
    correctnessPercentage,
    isAllSelected,
    quizzesCount,
    blocProgress,
    failureMessage,
  ];
}
