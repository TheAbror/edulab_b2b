part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final QuizRequest quizRequests;
  final List<NewQuizAnswers> answers;
  final List<String> answersIDS;
  final List<int> questionIDS;
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
    required this.answers,
    required this.answersIDS,
    required this.questionIDS,
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
    return QuizState(
      quizRequests: QuizRequest(
        stepId: 0,
        answers: [],
      ),
      answers: [],
      answersIDS: [],
      questionIDS: [],
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
    QuizRequest? quizRequests,
    List<NewQuizAnswers>? answers,
    List<String>? answersIDS,
    List<int>? questionIDS,
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
      answers: answers ?? this.answers,
      answersIDS: answersIDS ?? this.answersIDS,
      questionIDS: questionIDS ?? this.questionIDS,
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
    answers,
    answersIDS,
    questionIDS,
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
