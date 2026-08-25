import 'package:edulab_b2b/widget_imports.dart';

part 'courses_state.dart';

// TODO: remove once the backend (leti.slash.uz) is reachable again — for now this
// serves fixture data so the Courses tab can be designed without a live API.
const bool kUseMockCourseData = true;

class CoursesBloc extends Cubit<CoursesState> {
  CoursesBloc() : super(CoursesState.initial());

  void getAllCourses() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    if (kUseMockCourseData) {
      emit(
        state.copyWith(
          coursesAll: mockCourses,
          blocProgress: BlocProgress.LOADED,
        ),
      );
      return;
    }

    try {
      final response = await ApiProvider.coursesServices.getAllCourses();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              coursesAll: data.content,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          print(data);
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

  void getAllCoursesAsUnauthorized() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    if (kUseMockCourseData) {
      emit(
        state.copyWith(
          coursesAll: mockCourses,
          blocProgress: BlocProgress.LOADED,
        ),
      );
      return;
    }

    try {
      final response = await ApiProvider.coursesServices
          .getAllCoursesAsUnauthorized();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              coursesAll: data,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          print(data);
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

  void enrollToCourse(
    int courseID,
    ValueChanged<CourseEnrollmentResponse> onCall,
    ValueChanged<String> errorCase,
  ) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = EnrollmentRequest(courseID: courseID);

    try {
      final response = await ApiProvider.singleCourseServices.enrollToCourse(
        request,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              enrollmentResponse: data,
              blocProgress: BlocProgress.LOADED,
            ),
          );

          onCall(data);
        }
      } else {
        final error = ErrorResponse.fromJson(
          json.decode(response.error.toString()),
        );

        errorCase.call(error.message ?? '');

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

  Future<bool?> checkEnrollment(int id) async {
    emit(state.copyWith(singleCourseBlocProgress: BlocProgress.IS_LOADING));

    var isEnrolled = false;

    try {
      final response = await ApiProvider.singleCourseServices.checkEnrollment(
        id,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          isEnrolled = data.status == 'STARTED';
          emit(
            state.copyWith(
              enrollmentStatus: data.status,
              isEnrolled: data.status == 'STARTED',
              singleCourseBlocProgress: BlocProgress.LOADED,
            ),
          );
        }
      } else {
        final error = ErrorResponse.fromJson(
          json.decode(response.error.toString()),
        );

        emit(
          state.copyWith(
            singleCourseBlocProgress: BlocProgress.FAILED,
            failureMessage: error.message,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            singleCourseBlocProgress: BlocProgress.FAILED,
            failureMessage: AppStrings.internalErrorMessage,
          ),
        );
        debugPrint('$e');
      }
    }

    return isEnrolled;
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
}
