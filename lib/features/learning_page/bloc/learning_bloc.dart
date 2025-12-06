// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:leti_mobile/widget_imports.dart';

part 'learning_state.dart';

class LearningBloc extends Cubit<LearningState> {
  LearningBloc() : super(LearningState.initial());

  void resumeCourseById(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.resumeCourseById(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final ChapterModel _chapter = data.chapters.firstWhere(
            (c) => c.id == data.currentlyActive?.chapterID,
            orElse: () => ChapterModel.initial(),
          );

          final TopicModel _topic = _chapter.topics.firstWhere(
            (t) => t.id == data.currentlyActive?.topicID,
            orElse: () => TopicModel.initial(),
          );

          final StepModel _step = _topic.steps.firstWhere(
            (s) => s.id == data.currentlyActive?.stepID,
            orElse: () => StepModel.initial(),
          );

          emit(
            state.copyWith(
              resumedCourse: data,
              chapter: _chapter,
              topic: _topic,
              step: _step,
              allSteps: _topic.steps,
              courseID: id,
              chapterID: data.currentlyActive?.chapterID ?? 0,
              topicID: data.currentlyActive?.topicID ?? 0,
              stepID: data.currentlyActive?.stepID ?? 0,
              blocProgress: BlocProgress.LOADED,
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
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
      debugPrint('$e');
    }
  }

  void completeStep({
    required chapterID,
    required topicID,
    required stepID,
  }) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = CompleteStepRequest(
      chapterID: chapterID,
      topicID: topicID,
      stepID: stepID,
    );

    try {
      final response = await ApiProvider.singleCourseServices.completeStep(
        request,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              chapterID: data.nextChapterId,
              topicID: data.nextTopicId,
              stepID: data.nextStepId,
              blocProgress: BlocProgress.LOADED,
            ),
          );
        }

        resumeCourseById(state.courseID);
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
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
      debugPrint('$e');
    }
  }

  void expandPage(bool value) {
    emit(state.copyWith(isExpanded: value));
  }

  void manageSteps(int stepId, StepModel step) {
    emit(state.copyWith(stepID: stepId, step: step));
  }

  void appBarTabIndex(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }

  void changeMaterialsTabIndex(int index) {
    emit(state.copyWith(materialsTabIndex: index));
  }
}
