import 'package:leti_mobile/widget_imports.dart';

part 'quiz_state.dart';

class QuizBloc extends Cubit<QuizState> {
  QuizBloc() : super(QuizState.initial());

  void setQuizzesCount(int count) {
    emit(state.copyWith(quizzesCount: count));
  }

  void addQuizAnswer(NewQuizAnswers answer) {
    final updatedQuizzes = List<NewQuizAnswers>.from(state.answers);
    final ids = List<String>.from(state.answersIDS); // String
    final qIds = List<int>.from(state.questionIDS); // int

    final existingIndex = qIds.indexWhere((id) => id == answer.questionID);

    if (existingIndex != -1) {
      updatedQuizzes[existingIndex] = answer;
      ids[existingIndex] = answer.selectedOptionIds.first;
    } else {
      updatedQuizzes.add(answer);
      ids.add(answer.selectedOptionIds.first);
      qIds.add(answer.questionID);
    }

    emit(
      state.copyWith(
        answers: updatedQuizzes,
        answersIDS: ids,
        questionIDS: qIds,
        isAllSelected: updatedQuizzes.length == state.quizzesCount,
      ),
    );
  }

  Future<void> submitAllQuizzes(int stepID) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final req = QuizRequest(stepId: stepID, answers: state.answers);

      final response = await ApiProvider.singleCourseServices.submitQuiz(req);

      if (response.isSuccessful) {
        final data = response.body; // List<QuizResponse>

        if (data != null) {
          final correctAnswersCount = data
              .where((q) => q.status == QuizStatus.correct)
              .length;

          final total = data.length;

          final correctnessPercentage = total == 0
              ? 0
              : ((correctAnswersCount / total) * 100).round();

          emit(
            state.copyWith(
              correctAnswersCount: correctAnswersCount,
              overallAnswersCount: total,
              correctnessPercentage: correctnessPercentage,
              response: data,
              blocProgress: BlocProgress.IS_SUCCESS,
            ),
          );
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
      }
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
