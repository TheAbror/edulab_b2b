part of 'certificates_bloc.dart';

class CertificatesState extends Equatable {
  final int tabIndex;
  final List<CertificateByTopicIdModel> certificates;
  final List<AllTopicsContentResponse> topics;
  final BlocProgress blocProgress;
  final String failureMessage;

  const CertificatesState({
    required this.tabIndex,
    required this.certificates,
    required this.topics,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory CertificatesState.initial() {
    return CertificatesState(
      tabIndex: 0,
      certificates: const [],
      topics: const [],
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  CertificatesState copyWith({
    int? tabIndex,
    List<CertificateByTopicIdModel>? certificates,
    List<AllTopicsContentResponse>? topics,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return CertificatesState(
      tabIndex: tabIndex ?? this.tabIndex,
      certificates: certificates ?? this.certificates,
      topics: topics ?? this.topics,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        tabIndex,
        certificates,
        topics,
        blocProgress,
        failureMessage,
      ];
}
