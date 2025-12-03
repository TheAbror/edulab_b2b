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

      // Submit each quiz individually
      for (final quiz in state.quizRequests) {
        final response = await ApiProvider.singleCourseServices.submitQuiz(
          quiz,
        );

        if (response.isSuccessful) {
          final data = response.body;

          if (data != null) {
            collectedResponses.add(data);
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

      // If all submissions succeeded
      emit(
        state.copyWith(
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
}
