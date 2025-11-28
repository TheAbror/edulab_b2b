part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final int tabIndex;
  final BlocProgress blocProgress;
  final String failureMessage;

  const ProfileState({
    required this.tabIndex,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory ProfileState.initial() {
    return ProfileState(
      tabIndex: 0,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  ProfileState copyWith({
    int? tabIndex,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return ProfileState(
      tabIndex: tabIndex ?? this.tabIndex,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        tabIndex,
        blocProgress,
        failureMessage,
      ];
}
