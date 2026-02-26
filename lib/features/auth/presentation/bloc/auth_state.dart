part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final SignUpRequest request;
  final AuthResponse authResponse;
  final bool isPasswordHidden;
  final bool isCountDownFinished;
  final int timerSeconds;
  final bool isReponseSuccess;
  final bool isDisabled;
  final String emailOrPhone;
  final AccountType accountType;
  final BlocProgress blocProgress;
  final String failureMessage;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final bool isFirstAndLastNameValid;

  const AuthState({
    required this.request,
    required this.authResponse,
    required this.isPasswordHidden,
    required this.isCountDownFinished,
    required this.timerSeconds,
    required this.isReponseSuccess,
    required this.isDisabled,
    required this.emailOrPhone,
    required this.accountType,
    required this.blocProgress,
    required this.failureMessage,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isFirstAndLastNameValid,
  });

  factory AuthState.initial() {
    return AuthState(
      request: SignUpRequest(
        firstname: '',
        lastname: '',
        midname: '',
        email: '',
        password: '',
        phone: '',
        verificationCode: '',
        localeLanguageType: LocaleLanguageType(
          label: '',
          value: '',
        ),
      ),
      authResponse: AuthResponse(
        token: '',
        signUpRequired: false,
        userInfo: UserInfo(
          id: 0,
          username: '',
          firstname: '',
          lastname: '',
          roles: [],
          requiredActions: [],
          email: '',
          profilePhoto: MediaDTO.initial(),

          status: '',
          accountType: '',
          accountTypeStr: '',
        ),
      ),
      accountType: AccountType.unknown,
      isPasswordHidden: true,
      isCountDownFinished: false,
      timerSeconds: 60,
      isReponseSuccess: false,
      isDisabled: true,
      emailOrPhone: '',
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      phoneNumber: '',
      firstName: '',
      lastName: '',
      isFirstAndLastNameValid: false,
    );
  }

  AuthState copyWith({
    SignUpRequest? request,
    AuthResponse? authResponse,
    bool? isPasswordHidden,
    bool? isCountDownFinished,
    int? timerSeconds,
    bool? isReponseSuccess,
    bool? isDisabled,
    String? emailOrPhone,
    AccountType? accountType,
    BlocProgress? blocProgress,
    String? failureMessage,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isFirstAndLastNameValid,
  }) {
    return AuthState(
      request: request ?? this.request,
      authResponse: authResponse ?? this.authResponse,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isCountDownFinished: isCountDownFinished ?? this.isCountDownFinished,
      timerSeconds: timerSeconds ?? this.timerSeconds,

      isReponseSuccess: isReponseSuccess ?? this.isReponseSuccess,
      isDisabled: isDisabled ?? this.isDisabled,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      accountType: accountType ?? this.accountType,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isFirstAndLastNameValid:
          isFirstAndLastNameValid ?? this.isFirstAndLastNameValid,
    );
  }

  @override
  List<Object?> get props => [
    request,
    authResponse,
    isPasswordHidden,
    isCountDownFinished,
    timerSeconds,
    isReponseSuccess,
    isDisabled,
    emailOrPhone,
    accountType,
    blocProgress,
    failureMessage,
    phoneNumber,
    firstName,
    lastName,
    isFirstAndLastNameValid,
  ];
}
