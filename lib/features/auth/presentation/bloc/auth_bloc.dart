import 'package:leti_mobile/widget_imports.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState.initial());

  //!----------------------- Sign IN functions start -------------------------------//

  void signInStepOne(String phoneNumber) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignInStepOneRequest(
      phoneNumber: phoneNumber,
      locale: 'uz',
    );

    try {
      final response = await ApiProvider.authService.signInStepOne(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              phoneNumber: phoneNumber,
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

  void signInStepTwo(String code) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignInStepTwoRequest(
      phoneNumber: state.phoneNumber,
      locale: 'uz',
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
                PreferencesServices.saveUserInfo(
                  LocalStorageUserInfo(
                    id: user.id,
                    username: user.username,
                    firstName: user.firstname,
                    lastName: user.lastname,
                    account_type_str: user.accountType,
                    email: user.email,
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
                PreferencesServices.saveUserInfo(
                  LocalStorageUserInfo(
                    id: user.id,
                    username: user.username,
                    firstName: user.firstname,
                    lastName: user.lastname,
                    account_type_str: user.accountType,
                    email: user.email,
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

  void decrementTimerSeconds() {
    final currentSeconds = state.timerSeconds;
    if (currentSeconds > 0) {
      final newSeconds = currentSeconds - 1;
      emit(state.copyWith(timerSeconds: newSeconds));
    } else {
      emit(state.copyWith(isCountDownFinished: true));
    }
  }

  void setInitialValue() {
    emit(
      state.copyWith(
        isReponseSuccess: false,
        blocProgress: BlocProgress.NOT_STARTED,
        timerSeconds: 60,
        isCountDownFinished: false,
        isVerificationSuccess: false,
      ),
    );
  }

  void setPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void verificationSuccess(bool value) {
    emit(state.copyWith(isVerificationSuccess: value));
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

  void getVerificationCodeBySendingLogin(String signUpKey) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = GetVerificationCodeBySendingLogin(
      signInKey: signUpKey,
      type: 'PASSWORD_RESET',
    );

    try {
      final response = await ApiProvider.authService
          .getVerificationCodeBySendingLogin(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              // isRequestSent: true,
              isReponseSuccess: data.deleted,
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

  void resetPasswordToNew(String signUpKey) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = ResetPasswordToNew(newPassword: signUpKey);

    try {
      final response = await ApiProvider.authService.resetPasswordToNew(
        request,
      );

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          emit(
            state.copyWith(
              // isReponseSuccess: data.success,
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
