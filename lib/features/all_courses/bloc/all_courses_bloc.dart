import 'package:leti_mobile/widget_imports.dart';

part 'all_courses_state.dart';

class AllCoursesBloc extends Cubit<AllCoursesState> {
  AllCoursesBloc() : super(AllCoursesState.initial());

  void getCoursesByCategoryID(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.coursesServices.getCoursesByCategoryId(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              coursesByCategory: data,
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
