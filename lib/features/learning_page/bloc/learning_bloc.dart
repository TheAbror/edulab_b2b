// ignore_for_file: no_leading_underscores_for_local_identifiers, dead_code, unnecessary_null_comparison

import 'package:edulab_b2b/widget_imports.dart';

part 'learning_state.dart';

class LearningBloc extends Cubit<LearningState> {
  LearningBloc() : super(LearningState.initial());

  void resumeCourseById({
    required int id,
    CurrentlyActive? currentlyActive,
  }) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.resumeCourseById(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final lastStopped = currentlyActive ?? data.currentlyActive;

          final ChapterModel _chapter = data.chapters.firstWhere(
            (c) => c.id == lastStopped?.chapterID,
            orElse: () => ChapterModel.initial(),
          );

          final TopicModel _topic = _chapter.topics.firstWhere(
            (t) => t.id == lastStopped?.topicID,
            orElse: () => TopicModel.initial(),
          );

          final StepModel _step = _topic.steps.firstWhere(
            (s) => s.id == lastStopped?.stepID,
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
              chapterID: lastStopped?.chapterID ?? 0,
              topicID: lastStopped?.topicID ?? 0,
              stepID: lastStopped?.stepID ?? 0,
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
            status: StepItemStatus.completed,
          );

          final updatedSteps = List<StepModel>.from(state.allSteps);
          final stepIndex = updatedSteps.indexWhere(
            (step) => step.id == stepModel.id,
          );

          if (stepIndex != -1) {
            updatedSteps[stepIndex] = updatedSteps[stepIndex].copyWith(
              status: StepItemStatus.completed,
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

  /// Jump straight to a [topic] (and its parent [chapter]) picked from the
  /// course-content bottom sheet. All data already lives in [state.resumedCourse]
  /// so no extra network call is needed.
  void openTopic(ChapterModel chapter, TopicModel topic) {
    if (topic.steps.isEmpty) return;

    final firstStep = topic.steps.first;

    emit(
      state.copyWith(
        chapter: chapter,
        topic: topic,
        step: firstStep,
        allSteps: topic.steps,
        appbarTabIndex: 0,
        chapterID: chapter.id,
        topicID: topic.id,
        stepID: firstStep.id,
        blocProgress: BlocProgress.LOADED,
      ),
    );
  }

  void changeMaterialsTabIndex(int index) {
    emit(state.copyWith(materialsTabIndex: index));
  }

  void changeAppbarTabIndex(int appbarTabIndex, StepModel stepModel) {
    emit(
      state.copyWith(
        appbarTabIndex: appbarTabIndex,
        step: stepModel,
      ),
    );
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
              chapterID: data.nextChapterId,
              topicID: data.nextTopicId,
              stepID: data.nextStepId,
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

  void moveToPreviousTopic(TabController controller, StepModel stepModel) {
    final stepIndex = state.allSteps.indexWhere((s) => s.id == stepModel.id);

    if (stepIndex == 0) {
      final currentTopic = state.topic;
      final currentChapter = state.chapter;

      if (currentTopic == null || currentChapter == null) return;

      final currentTopicIndex = currentChapter.topics.indexWhere(
        (t) => t.id == currentTopic.id,
      );

      // Move to previous topic's last step
      if (currentTopicIndex > 0) {
        _moveToPreviousTopicLastStep(
          currentChapter,
          currentTopicIndex,
          controller,
        );
        return;
      }

      // No previous topic exists, move to previous chapter's last topic's last step
      _moveToPreviousChapterLastTopicLastStep(controller);
    }
  }

  void _moveToPreviousTopicLastStep(
    ChapterModel currentChapter,
    int currentTopicIndex,
    TabController controller,
  ) {
    final prevTopic = currentChapter.topics[currentTopicIndex - 1];

    if (prevTopic.steps.isEmpty) return;

    final lastStep = prevTopic.steps.last;

    emit(
      state.copyWith(
        chapterID: currentChapter.id,
        topicID: prevTopic.id,
        stepID: lastStep.id,
        chapter: currentChapter,
        topic: prevTopic,
        step: lastStep,
        allSteps: prevTopic.steps,
        appbarTabIndex: controller.length - 1,
      ),
    );

    controller.index = controller.length - 1;
  }

  void _moveToPreviousChapterLastTopicLastStep(TabController controller) {
    final currentChapter = state.chapter;
    if (currentChapter == null) return;

    final allChapters = state.resumedCourse.chapters;
    final currentChapterIndex = allChapters.indexWhere(
      (c) => c.id == currentChapter.id,
    );

    if (currentChapterIndex <= 0) return; // No previous chapter exists

    final prevChapter = allChapters[currentChapterIndex - 1];
    if (prevChapter.topics.isEmpty) return;

    final lastTopic = prevChapter.topics.last;
    if (lastTopic.steps.isEmpty) return;

    final lastStep = lastTopic.steps.last;

    emit(
      state.copyWith(
        chapterID: prevChapter.id,
        topicID: lastTopic.id,
        stepID: lastStep.id,
        chapter: prevChapter,
        topic: lastTopic,
        step: lastStep,
        allSteps: lastTopic.steps,
        appbarTabIndex: controller.length - 1,
      ),
    );

    controller.index = controller.length - 1;
  }
}
