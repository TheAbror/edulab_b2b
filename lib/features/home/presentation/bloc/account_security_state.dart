part of 'account_security_bloc.dart';

class AccountSecurityState extends Equatable {
  final bool showProfileInfo;
  final bool showCoursesInfo;
  final BlocProgress blocProgress;
  final String failureMessage;

  const AccountSecurityState({
    required this.showProfileInfo,
    required this.showCoursesInfo,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory AccountSecurityState.initial() {
    return AccountSecurityState(
      showProfileInfo: true,
      showCoursesInfo: true,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  AccountSecurityState copyWith({
    bool? showProfileInfo,
    bool? showCoursesInfo,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return AccountSecurityState(
      showProfileInfo: showProfileInfo ?? this.showProfileInfo,
      showCoursesInfo: showCoursesInfo ?? this.showCoursesInfo,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        showProfileInfo,
        showCoursesInfo,
        blocProgress,
        failureMessage,
      ];
}
