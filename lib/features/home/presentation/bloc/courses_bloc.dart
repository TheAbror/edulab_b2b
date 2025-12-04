import 'package:leti_mobile/widget_imports.dart';

part 'courses_state.dart';

class CoursesBloc extends Cubit<CoursesState> {
  CoursesBloc() : super(CoursesState.initial());

  Future<bool?> checkEnrollment(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    var isEnrolled = false;

    try {
      final response = await ApiProvider.singleCourseServices.checkEnrollment(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          isEnrolled = data.deleted;
          emit(
            state.copyWith(
              isEnrolled: data.deleted,
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

    return isEnrolled;
  }

  // all courses for recommended

  void getAllPossibleCourses() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.coursesServices
          .getAllPossibleCourses();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(coursesAll: data, blocProgress: BlocProgress.LOADED),
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

  void getCurrentCourse() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.coursesServices.getCurrentCourse();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              currentCourse: data,
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

  //! Get single selected course by its ID, mostly in recommended courses ends

  // to delete everything and aasign initial values
  void clearAll() {
    emit(CoursesState.initial());
  }

  //this functions is for 'show more' when displaying all subcategories Python, AWS ......show more....shows all of the subcategories

  void isSubcategoryExpanded(int index) {
    List<int> updatedList = List<int>.from(state.expandedSubcategoryIndexes);
    updatedList.add(index);

    emit(state.copyWith(expandedSubcategoryIndexes: updatedList));
  }

  void emptyExpandedSubcategoryIndexes() {
    emit(state.copyWith(expandedSubcategoryIndexes: []));
  }

  //!----------------------- Get category, subcategory, topics, courses functions start -------------------------------//

  void getAllCategories() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.coursesServices.getAllCategories();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(categories: data, blocProgress: BlocProgress.LOADED),
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

  //this is used in all categories page, it will open all subcategories page/topics
  void getCoursesByCategoryId(int id) async {
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
              courseByCategory: data,
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

  //!----------------------- Get category, subcategory, topics, courses functions end ------------------------------//
}
