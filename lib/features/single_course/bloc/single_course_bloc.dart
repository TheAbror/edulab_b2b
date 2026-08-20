import 'package:edulab_b2b/widget_imports.dart';

part 'single_course_state.dart';

class SingleCourseBloc extends Cubit<SingleCourseState> {
  SingleCourseBloc() : super(SingleCourseState.initial());

  void manageCourseMaterials() {
    emit(
      state.copyWith(
        courseMaterialsAreHidden: !state.courseMaterialsAreHidden,
        materialsMoreThan3: true,
      ),
    );
  }

  void manageRequested(bool value) {
    emit(state.copyWith(isRequested: value));
  }

  void manageNavigateToLearning(bool result) {
    emit(state.copyWith(navigateToLearning: result));
  }

  void manageDescriptionHidden() {
    emit(state.copyWith(isDescriptionHidden: !state.isDescriptionHidden));
  }

  void openSelectedTopic({
    required int courseId,
    required CurrentlyActive ids,
  }) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.openSelectedTopic(
        chapterId: ids.chapterID,
        courseId: courseId,
        stepId: ids.stepID,
        topicId: ids.topicID,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              navigateToLearning: true,
              lastStoppedStep: ids,
              courseID: courseId,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          print(state.courseMaterialsAreHidden);
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

  void getSingleCourse(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.getSingleCourse(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final content = data.syllabus?.courseContent;
          emit(
            state.copyWith(
              singleCourse: data,
              singleCourseChapters: data.chapters,
              lastStoppedStep: data.currentlyActive,
              courseMaterialsAreHidden: (content?.isNotEmpty == true)
                  ? ((content?.length ?? 0) > 3 ? true : false)
                  : false,
              materialsMoreThan3: (content?.isNotEmpty == true)
                  ? ((content?.length ?? 0) > 3 ? true : false)
                  : false,
              isFavorite: data.is_favorite,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          print(state.courseMaterialsAreHidden);
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
      if (!isClosed) {
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

  void getSingleCourseAsUnathorized(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices
          .getSingleCourseAsUnathorized(
            id,
          );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final content = data.syllabus?.courseContent;
          emit(
            state.copyWith(
              singleCourse: data,
              singleCourseChapters: data.chapters,
              lastStoppedStep: data.currentlyActive,
              courseMaterialsAreHidden: (content?.isNotEmpty == true)
                  ? ((content?.length ?? 0) > 3 ? true : false)
                  : false,
              materialsMoreThan3: (content?.isNotEmpty == true)
                  ? ((content?.length ?? 0) > 3 ? true : false)
                  : false,
              isFavorite: data.is_favorite,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          print(state.courseMaterialsAreHidden);
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
      if (!isClosed) {
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

  void postCourseAsFavorite(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = MakeCourseFavoriteRequest(courseID: id);

    try {
      final response = await ApiProvider.singleCourseServices
          .postCourseAsFavorite(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              isFavorite: !state.isFavorite,
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

  void clearAll() {
    emit(SingleCourseState.initial());
  }
}
