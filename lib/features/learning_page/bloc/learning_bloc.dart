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
              appbarTabIndex: _topic.steps.indexWhere((e) => e.id == _step.id),
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

  void completeStep(StepModel stepModel) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = CompleteStepRequest(
      chapterID: stepModel.chapterId ?? 0,
      topicID: stepModel.topicId ?? 0,
      stepID: stepModel.id,
    );

    try {
      final response = await ApiProvider.singleCourseServices.completeStep(
        request,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final completedStep = state.step.copyWith(
            status: 'COMPLETED',
          );

          final updatedSteps = List<StepModel>.from(state.allSteps);
          final stepIndex = updatedSteps.indexWhere(
            (step) => step.id == stepModel.id,
          );

          if (stepIndex != -1) {
            updatedSteps[stepIndex] = updatedSteps[stepIndex].copyWith(
              status: 'COMPLETED',
            );
          }
          if (data.topicCompleted) {
            emit(
              state.copyWith(
                chapterID: data.nextChapterId,
                topicID: data.nextTopicId,
                stepID: data.nextStepId,
              ),
            );
          }

          emit(
            state.copyWith(
              step: completedStep,
              allSteps: updatedSteps,
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

  void expandPage(bool value) {
    emit(state.copyWith(isExpanded: value));
  }

  // void moveToNextStep() {
  //   final newList = List<StepModel>.from(state.allSteps);

  //   emit(state.copyWith(step: newList[state.appbarTabIndex + 1]));
  // }

  void changeMaterialsTabIndex(int index) {
    emit(state.copyWith(materialsTabIndex: index));
  }

  void changeAppbarTabIndex(int appbarTabIndex) {
    emit(state.copyWith(appbarTabIndex: appbarTabIndex));
  }

  void moveToNextTopic(StepModel stepModel) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = CompleteStepRequest(
      chapterID: stepModel.chapterId ?? 0,
      topicID: stepModel.topicId ?? 0,
      stepID: stepModel.id,
    );

    try {
      final response = await ApiProvider.singleCourseServices.completeStep(
        request,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final _chapter = state.resumedCourse.chapters.firstWhere(
            (e) => e.id == data.nextChapterId,
            orElse: ChapterModel.initial,
          );

          final _topic = _chapter.topics.firstWhere(
            (e) => e.id == data.nextTopicId,
            orElse: TopicModel.initial,
          );

          final _step = _topic.steps.firstWhere(
            (e) => e.id == data.nextStepId,
            orElse: StepModel.initial,
          );

          emit(
            state.copyWith(
              appbarTabIndex: 0,
              chapter: _chapter,
              topic: _topic,

              step: _step,
              allSteps: _topic.steps,

              // final ChapterModel chapter;
              // final TopicModel topic;
              // final StepModel step;
              // final List<StepModel> allSteps;
              chapterID: data.nextChapterId,
              topicID: data.nextTopicId,
              stepID: data.nextStepId,
              blocProgress: BlocProgress.LOADED,
            ),
          );
          // emit(LearningState.initial());

          // resumeCourseById(state.courseID);
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
}
