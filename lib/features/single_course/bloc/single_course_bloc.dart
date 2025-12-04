import 'package:leti_mobile/widget_imports.dart';

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

  void manageDescriptionHidden() {
    emit(state.copyWith(isDescriptionHidden: !state.isDescriptionHidden));
  }

  void getSingleStepByID({
    required int chapterId,
    required int courseId,
    required int topicId,
  }) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.singleCourseServices.getSingleStepByID(
        chapterId: chapterId,
        courseId: courseId,
        stepId: 0,
        topicId: topicId,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              //
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
              lastStoppedStep: data.currentlyActive, //TODO work in here
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
