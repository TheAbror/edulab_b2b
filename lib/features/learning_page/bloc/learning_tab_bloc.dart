import 'package:leti_mobile/widget_imports.dart';

part 'learning_tab_state.dart';

class LearningPageBloc extends Cubit<LearningPageState> {
  LearningPageBloc() : super(LearningPageState.initial());

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
              lastStoppedStep: data.currentlyActive,
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
