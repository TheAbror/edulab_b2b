part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isDialogShownFirstTime;
  final int tabIndex;
  final bool isLightTheme;
  final InternetStatus internetStatus;
  final BlocProgress blocProgress;
  final String failureMessage;

  const HomeState({
    required this.tabIndex,
    required this.isDialogShownFirstTime,
    required this.isLightTheme,
    required this.internetStatus,

    required this.blocProgress,
    required this.failureMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      tabIndex: 0,
      isDialogShownFirstTime: true,
      isLightTheme: true,
      internetStatus: InternetStatus.connected,

      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  HomeState copyWith({
    bool? isDialogShownFirstTime,
    int? tabIndex,
    bool? isLightTheme,
    InternetStatus? internetStatus,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return HomeState(
      isDialogShownFirstTime:
          isDialogShownFirstTime ?? this.isDialogShownFirstTime,
      tabIndex: tabIndex ?? this.tabIndex,
      isLightTheme: isLightTheme ?? this.isLightTheme,
      internetStatus: internetStatus ?? this.internetStatus,

      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    isDialogShownFirstTime,
    tabIndex,
    isLightTheme,
    internetStatus,
    blocProgress,
    failureMessage,
  ];
}
