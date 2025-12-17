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

  initialTheme() {
    final bool? isLight = PreferencesServices.getTheme();
    final returnedNULL = isLight == null;
    final validResult = isLight != null;

    if (returnedNULL) {
      emit(
        state.copyWith(
          isSystemDefault: returnedNULL ? true : false,
          isLightTheme: false,
          isDark: false,
        ),
      );
    }
    if (validResult) {
      emit(
        state.copyWith(
          isSystemDefault: false,
          isLightTheme: isLight,
          isDark: !isLight,
        ),
      );
    }
  }

  void setDark() {
    PreferencesServices.saveTheme(false);
    emit(
      state.copyWith(
        isLightTheme: false,
        isSystemDefault: false,
        isDark: true,
      ),
    );
  }

  void setLight() {
    PreferencesServices.saveTheme(true);
    emit(
      state.copyWith(
        isLightTheme: true,
        isSystemDefault: false,
        isDark: false,
      ),
    );
  }

  void setSystem(bool isLight) {
    PreferencesServices.saveTheme(null);

    emit(
      state.copyWith(
        isSystemDefault: true,
        isLightTheme: false,
        isDark: false,
      ),
    );
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
