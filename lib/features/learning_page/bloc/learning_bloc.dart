// ignore_for_file: no_leading_underscores_for_local_identifiers, dead_code, unnecessary_null_comparison

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

  // void moveToPreviousTopicasassas(StepModel stepModel) async {
  //   final _chapter = state.chapter;
  //   final _allChapters = state.resumedCourse.chapters;
  //   final chapterIndex = _allChapters.indexWhere((e) => e.id == _chapter.id);
  //   final _previousChapter = _allChapters[chapterIndex - 1];
  //   final _firstTopic = _previousChapter.topics.first;
  //   final _firstTopicID = _previousChapter.topics.first.id;
  //   final _firstStepID = _firstTopic.steps.first.id;

  //   emit(
  //     state.copyWith(
  //       appbarTabIndex: 0,
  //       chapterID: _previousChapter.id,
  //       topicID: _firstTopicID,
  //       stepID: _firstStepID,

  //       chapter: _previousChapter,
  //       topic: _firstTopic,
  //       step: _firstTopic.steps.first,
  //       allSteps: _firstTopic.steps,
  //     ),
  //   );
  // }

  // void moveToPreviousTopic(StepModel stepModel) {
  //   final _currentChapter = state.chapter;
  //   final _currentTopics = _currentChapter.topics;
  //   final _currentTopic = _currentTopics.indexWhere(
  //     (e) => e.id == state.topic.id,
  //   );
  //   if (_currentTopic == -1) return;
  //   final indexOfCurrentTopic = _currentTopics.indexWhere(
  //     (e) => e.id == _currentTopic,
  //   );
  //   if (indexOfCurrentTopic == -1) return;
  //   // final firstTopicID = _currentChapter.topics.first.id;
  //   final previouseTopic = _currentTopics[indexOfCurrentTopic - 1];

  // }

  // void moveToPreviousTopicLastStep({
  //   required currentTopicIndex,
  //   required TabController controller,
  // }) {
  //   final topicIndex = chapter.topics.indexWhere((t) => t.id == topic.id);
  //   final prevTopic = state.chapter.topics[topicIndex - 1];

  //   if (prevTopic.steps.isEmpty) return;

  //   final lastStep = prevTopic.steps.last;

  //   emit(
  //     state.copyWith(
  //       chapterID: chapter.id,
  //       topicID: prevTopic.id,
  //       stepID: lastStep.id,
  //       chapter: chapter,
  //       topic: prevTopic,
  //       step: lastStep,
  //       allSteps: prevTopic.steps,
  //       appbarTabIndex: 2,
  //     ),
  //   );

  //   controller.index = controller.length - 1;
  // }

  // void moveToPreviousTopicOrStep(
  //   StepModel stepModel,
  //   TabController controller,
  // ) {
  //   // Handle tab navigation
  //   if (controller.index > 0) {
  //     controller.index--;
  //     return;
  //   }

  //   final currentChapter = state.chapter;
  //   final currentTopic = state.topic;
  //   final currentStep = state.step;

  //   if (currentChapter == null || currentTopic == null || currentStep == null) {
  //     return;
  //   }

  //   _navigateToPrevious(
  //     currentChapter,
  //     currentTopic,
  //     currentStep,
  //     controller,
  //   ); // Pass controller
  // }

  // void _navigateToPrevious(
  //   ChapterModel chapter,
  //   TopicModel topic,
  //   StepModel step,
  //   TabController controller, // Add controller parameter
  // ) {
  //   final stepIndex = topic.steps.indexWhere((s) => s.id == step.id);

  //   // Case 1: Move to previous step in current topic
  //   if (stepIndex > 0) {
  //     _moveToPreviousStep(topic, stepIndex, controller); // Pass controller
  //     return;
  //   }

  //   final topicIndex = chapter.topics.indexWhere((t) => t.id == topic.id);

  //   // Case 2: Move to last step of previous topic
  //   if (topicIndex > 0) {
  //     _moveToPreviousTopicLastStep(
  //       chapter,
  //       topicIndex,
  //       controller,
  //     ); // Pass controller
  //     return;
  //   }

  //   // Case 3: Move to last step of last topic in previous chapter
  //   final chapterIndex = state.resumedCourse.chapters.indexWhere(
  //     (c) => c.id == chapter.id,
  //   );

  //   _moveToPreviousChapterLastTopicLastStep(
  //     chapterIndex,
  //     state.resumedCourse.chapters,
  //     controller, // Pass controller
  //   );
  // }

  // void _moveToPreviousStep(
  //   TopicModel topic,
  //   int currentStepIndex,
  //   TabController controller, // Add controller parameter
  // ) {
  //   final prevStep = topic.steps[currentStepIndex - 1];

  //   emit(
  //     state.copyWith(
  //       stepID: prevStep.id,
  //       step: prevStep,
  //       allSteps: topic.steps,
  //     ),
  //   );

  //   // Set tab to last tab for the previous step
  //   controller.index = controller.length - 1;
  // }

  // void _moveToPreviousChapterLastTopicLastStep(
  //   int chapterIndex,
  //   List<ChapterModel> allChapters,
  //   TabController controller, // Add controller parameter
  // ) {
  //   if (chapterIndex == 0) return;

  //   final prevChapter = allChapters[chapterIndex - 1];
  //   if (prevChapter.topics.isEmpty) return;

  //   final lastTopic = prevChapter.topics.last;
  //   if (lastTopic.steps.isEmpty) return;

  //   final lastStep = lastTopic.steps.last;

  //   emit(
  //     state.copyWith(
  //       chapterID: prevChapter.id,
  //       topicID: lastTopic.id,
  //       stepID: lastStep.id,
  //       chapter: prevChapter,
  //       topic: lastTopic,
  //       step: lastStep,
  //       allSteps: lastTopic.steps,
  //     ),
  //   );

  //   // Set tab to last tab
  //   controller.index = controller.length - 1;
  // }
}
