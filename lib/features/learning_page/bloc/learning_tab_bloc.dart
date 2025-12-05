import 'package:leti_mobile/widget_imports.dart';

part 'learning_tab_state.dart';

class LearningPageBloc extends Cubit<LearningPageState> {
  LearningPageBloc() : super(LearningPageState.initial());

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

  void changeTabIndex(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }

  void changeMaterialsTabIndex(int index) {
    emit(state.copyWith(materialsTabIndex: index));
  }

  void resumeCourseById(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.resumeCourseById(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              resumedCourse: data,
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
}
