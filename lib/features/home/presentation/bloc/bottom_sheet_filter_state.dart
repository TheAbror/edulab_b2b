part of 'bottom_sheet_filter_bloc.dart';

class BottomSheetFilterState extends Equatable {
  final bool isTopicTileOpen;
  final bool isLevelTileOpen;
  final bool isLanguageTileOpen;
  final List<int> listOfSelectedTopicIndexes;
  final List<int> listOfSelectedLevelIndexes;
  final List<int> listOfSelectedLanguageIndexes;
  final bool isCertificateSwitchOn;
  final bool isFreeCourseSwitchOn;
  final bool isAllTopicsShown;
  final double heightRatio;
  final BlocProgress blocProgress;
  final String failureMessage;

  const BottomSheetFilterState({
    required this.isTopicTileOpen,
    required this.isLevelTileOpen,
    required this.isLanguageTileOpen,
    required this.listOfSelectedTopicIndexes,
    required this.listOfSelectedLevelIndexes,
    required this.listOfSelectedLanguageIndexes,
    required this.isCertificateSwitchOn,
    required this.isFreeCourseSwitchOn,
    required this.isAllTopicsShown,
    required this.heightRatio,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory BottomSheetFilterState.initial() {
    return BottomSheetFilterState(
      isTopicTileOpen: false,
      isLevelTileOpen: false,
      isLanguageTileOpen: false,
      listOfSelectedTopicIndexes: const [],
      listOfSelectedLevelIndexes: const [],
      listOfSelectedLanguageIndexes: const [],
      isCertificateSwitchOn: false,
      isFreeCourseSwitchOn: false,
      isAllTopicsShown: false,
      heightRatio: 0.5,
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  BottomSheetFilterState copyWith({
    bool? isTopicTileOpen,
    bool? isLevelTileOpen,
    bool? isLanguageTileOpen,
    List<int>? listOfSelectedTopicIndexes,
    List<int>? listOfSelectedLevelIndexes,
    List<int>? listOfSelectedLanguageIndexes,
    bool? isCertificateSwitchOn,
    bool? isFreeCourseSwitchOn,
    bool? isAllTopicsShown,
    double? heightRatio,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return BottomSheetFilterState(
      isTopicTileOpen: isTopicTileOpen ?? this.isTopicTileOpen,
      isLevelTileOpen: isLevelTileOpen ?? this.isLevelTileOpen,
      isLanguageTileOpen: isLanguageTileOpen ?? this.isLanguageTileOpen,
      listOfSelectedTopicIndexes: listOfSelectedTopicIndexes ?? this.listOfSelectedTopicIndexes,
      listOfSelectedLevelIndexes: listOfSelectedLevelIndexes ?? this.listOfSelectedLevelIndexes,
      listOfSelectedLanguageIndexes:
          listOfSelectedLanguageIndexes ?? this.listOfSelectedLanguageIndexes,
      isCertificateSwitchOn: isCertificateSwitchOn ?? this.isCertificateSwitchOn,
      isFreeCourseSwitchOn: isFreeCourseSwitchOn ?? this.isFreeCourseSwitchOn,
      isAllTopicsShown: isAllTopicsShown ?? this.isAllTopicsShown,
      heightRatio: heightRatio ?? this.heightRatio,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        isTopicTileOpen,
        isLevelTileOpen,
        isLanguageTileOpen,
        listOfSelectedTopicIndexes,
        listOfSelectedLevelIndexes,
        listOfSelectedLanguageIndexes,
        isCertificateSwitchOn,
        isFreeCourseSwitchOn,
        isAllTopicsShown,
        heightRatio,
        blocProgress,
        failureMessage,
      ];
}
