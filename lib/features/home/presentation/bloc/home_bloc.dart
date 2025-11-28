import 'package:leti_mobile/widget_imports.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.initial());

  void getTeacherById(int id) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.homeServices.getTeacherById(id);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              teachersById: data,
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

  void initialTheme() {
    // final settings = settingsBox.get(ShPrefKeys.projectSettings);

    emit(
      state.copyWith(
        // isSystemDefault: settings.isSystemDefault ?? true,
        // isLightTheme: settings.isLight ?? true,
      ),
    );
  }

  void changeTheme(bool isLight) {
    // final settings = settingsBox.get(ShPrefKeys.projectSettings);

    // settingsBox.put(
    //   ShPrefKeys.projectSettings,
    //   settings.copyWith(isLight: isLight, isSystemDefault: false),
    // );

    emit(state.copyWith(isLightTheme: isLight, isSystemDefault: false));
  }

  void changeSystemDefaultTheme(bool isLight) async {
    // final settings = settingsBox.get(ShPrefKeys.projectSettings);

    // settingsBox.put(
    //   ShPrefKeys.projectSettings,
    //   settings.copyWith(isSystemDefault: isLight),
    // );

    emit(state.copyWith(isSystemDefault: isLight));
  }

  void isDialogShownFirstTime() {
    emit(state.copyWith(isDialogShownFirstTime: false));
  }

  //! < ---------------------------------------------------------->

  void clearAll() {
    emit(HomeState.initial());
  }

  void getTeachersList() async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    try {
      final response = await ApiProvider.homeServices.getTeachersList();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(teachers: data, blocProgress: BlocProgress.LOADED),
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

  void changeTabIndex(int index) {
    emit(state.copyWith(tabIndex: index));
  }
}
