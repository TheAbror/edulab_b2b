import 'package:edulab_b2b/widget_imports.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState.initial());

  // The mobile sign-in endpoints (LoginInDTO / LoginEnterCodeDTO) require an
  // account_type. This app only signs in learners.
  static const String _accountType = 'ORGANIZATION';

  // signin/step_* only accepts en | ru | uz.
  String get _locale {
    final lang = PreferencesServices.getLangCode();
    return (lang == 'en' || lang == 'ru' || lang == 'uz') ? lang! : 'uz';
  }

  //!----------------------- Sign IN functions start -------------------------------//

  void signInStepOne(
    String phoneNumber,
    bool? isResentCode,
  ) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignInStepOneRequest(
      phoneNumber: phoneNumber,
      accountType: _accountType,
      locale: _locale,
    );

    try {
      final response = await ApiProvider.authService.signInStepOne(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              phoneNumber: phoneNumber,
              blocProgress: isResentCode == true
                  ? BlocProgress.NOT_STARTED
                  : BlocProgress.IS_SUCCESS,
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
      debugPrint('Error getting inquiries: $e');
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
    }
  }

  void signInStepTwo(String code) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignInStepTwoRequest(
      phoneNumber: state.phoneNumber,
      accountType: _accountType,
      locale: _locale,
      code: code,
    );

    try {
      final response = await ApiProvider.authService.signInStepTwo(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          if (data.signUpRequired != null) {
            if (data.signUpRequired == false) {
              final user = data.userInfo;

              if (user != null && data.token != null) {
                PreferencesServices.saveToken(data.token ?? '');
                PreferencesServices.saveAuthStatus(true);
                PreferencesServices.saveUserInfo(
                  LocalStorageUserInfo(
                    id: user.id,
                    username: user.username,
                    firstName: user.firstname,
                    lastName: user.lastname,
                    account_type_str: user.accountType,
                    email: user.email,
                    phone: user.phone,
                    department: user.department,
                    jobPosition: user.jobPosition,
                    status: user.status,
                    profile_photo: user.profilePhoto,
                  ),
                );

                ApiProvider.create(token: data.token);
              }
            }
          }

          emit(
            state.copyWith(
              authResponse: data,
              blocProgress: BlocProgress.IS_SUCCESS,
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
      debugPrint('Error getting inquiries: $e');
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: e.toString(),
        ),
      );
    }
  }

  void signInStepThree(String firstname, String lastname) async {
    setInitialValue();

    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignInStepThreeRequest(
      phoneNumber: state.phoneNumber,
      email: state.email,
      locale: 'uz',
      firstname: firstname,
      lastname: lastname,
    );

    try {
      final response = await ApiProvider.authService.signInStepThree(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          if (data.signUpRequired != null) {
            if (data.signUpRequired == false) {
              final user = data.userInfo;

              if (user != null && data.token != null) {
                PreferencesServices.saveToken(data.token ?? '');
                PreferencesServices.saveAuthStatus(true);

                PreferencesServices.saveUserInfo(
                  LocalStorageUserInfo(
                    id: user.id,
                    username: user.username,
                    firstName: user.firstname,
                    lastName: user.lastname,
                    account_type_str: user.accountType,
                    email: user.email,
                    phone: user.phone,
                    department: user.department,
                    jobPosition: user.jobPosition,
                    status: user.status,
                    profile_photo: user.profilePhoto,
                  ),
                );

                ApiProvider.create(token: data.token);
              }
            }
          }

          emit(
            state.copyWith(
              authResponse: data,
              blocProgress: BlocProgress.IS_SUCCESS,
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
      debugPrint('Error getting inquiries: $e');
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: e.toString(),
        ),
      );
    }
  }

  //!<----------------------- Sign IN functions end ------------------------------>//

  //!----------------------- Small Bloc functions start -------------------------------//

  void saveLogin(String emailOrPhone) {
    emit(state.copyWith(emailOrPhone: emailOrPhone));
  }

  void makeBlocProgressNotStarted() {
    emit(state.copyWith(blocProgress: BlocProgress.NOT_STARTED));
  }

  void saveLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));

    if (state.lastName.isNotEmpty && state.firstName.isNotEmpty) {
      emit(state.copyWith(isFirstAndLastNameValid: true));
    }
  }

  void saveFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
    if (state.lastName.isNotEmpty && state.firstName.isNotEmpty) {
      emit(state.copyWith(isFirstAndLastNameValid: true));
    }
  }

  void enableButton() {
    emit(state.copyWith(isDisabled: false));
  }

  void disableButton() {
    emit(state.copyWith(isDisabled: true));
  }

  void decrementTimerSeconds() {
    final currentSeconds = state.timerSeconds;

    if (currentSeconds == 0) {
      emit(state.copyWith(isCountDownFinished: true));
    }

    if (currentSeconds > 0) {
      final newSeconds = currentSeconds - 1;
      emit(state.copyWith(timerSeconds: newSeconds));
    }
  }

  void setInitialValue() {
    emit(
      state.copyWith(
        isReponseSuccess: false,
        blocProgress: BlocProgress.NOT_STARTED,
        timerSeconds: 60,
        isCountDownFinished: false,
      ),
    );
  }

  void setPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void setAuthMethod(AuthMethod method) {
    emit(
      state.copyWith(
        authMethod: method,
        isDisabled: true,
        blocProgress: BlocProgress.NOT_STARTED,
        failureMessage: '',
      ),
    );
  }

  void isPasswordHidden() {
    final item = !state.isPasswordHidden;
    emit(state.copyWith(isPasswordHidden: item));
  }

  void clearAll() {
    emit(AuthState.initial());
  }

  //!<----------------------- Small Bloc functions end ------------------------------>//

  //!----------------------- Forgot password functions start -------------------------------//

  //!<----------------------- Forgot password functions end ------------------------------>//

  //!----------------------- Sign UP functions start -------------------------------//

  void sendSignUpKeyForVerification(String signUpKey) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignUpKeyRequest(recipient: signUpKey, type: 'SIGN_UP');

    try {
      final response = await ApiProvider.authService
          .sendSignUpKeyForVerification(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              // wasVerificationSentSuccessfully: data.success,
              blocProgress: BlocProgress.IS_SUCCESS,
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
      debugPrint('Error getting inquiries: $e');
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
    }
  }

  //!<----------------------- Sign UP functions end ------------------------------>//
}
