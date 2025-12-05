import 'package:leti_mobile/widget_imports.dart';

part 'quiz_state.dart';

class QuizBloc extends Cubit<QuizState> {
  QuizBloc() : super(QuizState.initial());

  void setQuizzesCount(int count) {
    emit(state.copyWith(quizzesCount: count));
  }

  void addQuizAnswer(QuizRequest quizRequest) {
    final updatedQuizzes = List<QuizRequest>.from(state.quizRequests);

    // Check if quiz for this question already exists
    final existingIndex = updatedQuizzes.indexWhere(
      (quiz) => quiz.questionId == quizRequest.questionId,
    );

    if (existingIndex != -1) {
      // Update existing quiz
      updatedQuizzes[existingIndex] = quizRequest;
    } else {
      updatedQuizzes.add(quizRequest);
    }

    emit(state.copyWith(quizRequests: updatedQuizzes));

    if (updatedQuizzes.length == state.quizzesCount) {
      emit(state.copyWith(isAllSelected: true));
    }
  }

  Future<void> submitAllQuizzes() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final List<QuizResponse> collectedResponses = [];

      // ignore: no_leading_underscores_for_local_identifiers
      var _correctAnswersCount = 0;

      // Submit each quiz individually
      for (final quiz in state.quizRequests) {
        final response = await ApiProvider.singleCourseServices.submitQuiz(
          quiz,
        );

        if (response.isSuccessful) {
          final data = response.body;

          if (data != null) {
            collectedResponses.add(data);

            if (data.status == "CORRECT") {
              _correctAnswersCount = _correctAnswersCount + 1;
            }
          }
        } else {
          final error = ErrorResponse.fromJson(
            json.decode(response.error.toString()),
          );

          emit(
            state.copyWith(
              blocProgress: BlocProgress.FAILED,
              failureMessage: error.message,
            ),
          );
          return;
        }
      }

      final correct = _correctAnswersCount;
      final total = collectedResponses.length;

      final correctnessPercentage = total == 0
          ? 0
          : ((correct / total) * 100).round();

      emit(
        state.copyWith(
          correctAnswersCount: correct,
          overallAnswersCount: total,
          correctnessPercentage: correctnessPercentage,
          response: collectedResponses,
          blocProgress: BlocProgress.IS_SUCCESS,
        ),
      );
    } catch (e) {
      debugPrint('Error submitting quizzes: $e');

      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
    }
  }

  void clearAll() {
    final count = state.quizzesCount;
    emit(QuizState.initial());

    emit(state.copyWith(quizzesCount: count));
  }
}
