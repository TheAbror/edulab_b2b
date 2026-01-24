part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final SignUpRequest request;
  final AuthResponse authResponse;
  final bool isPasswordHidden;
  final bool isCountDownFinished;
  final int timerSeconds;
  final bool isVerificationSuccess;
  final bool isReponseSuccess;
  final bool isDisabled;
  final String emailOrPhone;
  final AccountType accountType;
  final BlocProgress blocProgress;
  final String failureMessage;
  final String phoneNumber;

  const AuthState({
    required this.request,
    required this.authResponse,
    required this.isPasswordHidden,
    required this.isCountDownFinished,
    required this.timerSeconds,
    required this.isVerificationSuccess,
    required this.isReponseSuccess,
    required this.isDisabled,
    required this.emailOrPhone,
    required this.accountType,
    required this.blocProgress,
    required this.failureMessage,
    required this.phoneNumber,
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
        userInfo: UserInfo(
          id: 0,
          username: '',
          firstname: '',
          lastname: '',
          roles: [],
          requiredActions: [],
          email: '',
          profilePhoto: MediaDTO(
            original_name: '',
            src: '',
            file_size: 0,
            original_url: '',
            thumb_url: '',
            url: '',
            extension: '',
          ),
          status: '',
          accountType: '',
          accountTypeStr: '',
        ),
      ),
      accountType: AccountType.unknown,
      isPasswordHidden: true,
      isCountDownFinished: false,
      timerSeconds: 60,
      isVerificationSuccess: false,
      isReponseSuccess: false,
      isDisabled: true,
      emailOrPhone: '',
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      phoneNumber: '',
    );
  }

  AuthState copyWith({
    SignUpRequest? request,
    AuthResponse? authResponse,
    bool? isPasswordHidden,
    bool? isCountDownFinished,
    int? timerSeconds,
    bool? isVerificationSuccess,
    bool? isReponseSuccess,
    bool? isDisabled,
    String? emailOrPhone,
    AccountType? accountType,
    BlocProgress? blocProgress,
    String? failureMessage,
    String? phoneNumber,
  }) {
    return AuthState(
      request: request ?? this.request,
      authResponse: authResponse ?? this.authResponse,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isCountDownFinished: isCountDownFinished ?? this.isCountDownFinished,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isVerificationSuccess:
          isVerificationSuccess ?? this.isVerificationSuccess,
      isReponseSuccess: isReponseSuccess ?? this.isReponseSuccess,
      isDisabled: isDisabled ?? this.isDisabled,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      accountType: accountType ?? this.accountType,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
    request,
    authResponse,
    isPasswordHidden,
    isCountDownFinished,
    timerSeconds,
    isVerificationSuccess,
    isReponseSuccess,
    isDisabled,
    emailOrPhone,
    accountType,
    blocProgress,
    failureMessage,
    phoneNumber,
  ];
}
