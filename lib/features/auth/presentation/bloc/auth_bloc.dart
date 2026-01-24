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
          final user = data.userInfo;

          PreferencesServices.saveToken(data.token);
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
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
    }
  }
  //!<----------------------- Sign IN functions end ------------------------------>//

  //!----------------------- Small Bloc functions start -------------------------------//

  void saveLogin(String emailOrPhone) {
    emit(state.copyWith(emailOrPhone: emailOrPhone));
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
        timerSeconds: 10,
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

  void signUp(
    String firstname,
    String lastname,
    String login,
    String password,
  ) async {
    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    final request = SignUpRequest(
      firstname: firstname,
      lastname: lastname,
      midname: '',
      email: login,
      password: password,
      phone: login.contains('@') ? '' : login,
      verificationCode: '12345',
      localeLanguageType: LocaleLanguageType(label: '', value: ''),
    );

    try {
      final response = await ApiProvider.authService.signUP(request);

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          final token = data.token;

          emit(
            state.copyWith(
              authResponse: data,
              isReponseSuccess: true,
              blocProgress: BlocProgress.IS_SUCCESS,
            ),
          );

          ApiProvider.create(token: token);

          // userDataBox.put(
          //   ProjectKeys.userData,
          //   UserData(token: data.token),
          // );
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
