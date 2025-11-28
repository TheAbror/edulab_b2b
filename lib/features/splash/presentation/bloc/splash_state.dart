part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final AppVersionResponse appVersionData;
  final bool showAppUpdatesPage;
  final SplashAuthStatus authStatus;
  final AccountType accountType;
  final BlocProgress blocProgress;
  final String failureMessage;
  // app status variables

  final int minVersion;
  final int latestAppVersion;
  final int buildNumber;

  const SplashState({
    required this.appVersionData,
    required this.latestAppVersion,
    required this.minVersion,
    required this.buildNumber,
    required this.showAppUpdatesPage,
    required this.authStatus,
    required this.accountType,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory SplashState.initial() {
    return SplashState(
      appVersionData: AppVersionResponse(
        showMaintanance: false,
        iosMinVersion: 1,
        iosLatestVersion: 1,
        androidMinVersion: 1,
        androidLatestVersion: 1,
        iosStoreUrl: '',
        androidStoreUrl: '',
        title: '',
        description: '',
      ),
      showAppUpdatesPage: false,
      authStatus: SplashAuthStatus.initial,
      accountType: AccountType.unknown,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
      // app status variables

      minVersion: 0,
      latestAppVersion: 0,
      buildNumber: 0,
    );
  }

  SplashState copyWith({
    AppVersionResponse? appVersionData,
    bool? showAppUpdatesPage,
    SplashAuthStatus? authStatus,
    BlocProgress? blocProgress,
    String? failureMessage,
    AccountType? accountType,
    //

    int? minVersion,
    int? latestAppVersion,
    int? buildNumber,
  }) {
    return SplashState(
      appVersionData: appVersionData ?? this.appVersionData,
      showAppUpdatesPage: showAppUpdatesPage ?? this.showAppUpdatesPage,
      authStatus: authStatus ?? this.authStatus,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
      accountType: accountType ?? this.accountType,
      //

      minVersion: minVersion ?? this.minVersion,
      latestAppVersion: latestAppVersion ?? this.latestAppVersion,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }

  @override
  List<Object?> get props => [
        appVersionData,
        showAppUpdatesPage,
        authStatus,
        blocProgress,
        failureMessage,
        accountType,
        minVersion,
        latestAppVersion,
        buildNumber,
      ];
}
