import 'package:leti_mobile/widget_imports.dart';

part 'bottom_sheet_filter_state.dart';

class BottomSheetFilterBloc extends Cubit<BottomSheetFilterState> {
  BottomSheetFilterBloc() : super(BottomSheetFilterState.initial());

  //!----------------------- BottomSheet minor functions start -------------------------------//

  void addToSelectedTopicList(int index) {
    List<int> updatedSelection = List<int>.from(
      state.listOfSelectedTopicIndexes,
    );

    if (updatedSelection.contains(index)) {
      updatedSelection.remove(index);
    } else {
      updatedSelection.add(index);
    }

    emit(state.copyWith(listOfSelectedTopicIndexes: updatedSelection));
  }

  void addToSelectedLevelList(int index) {
    List<int> updatedSelection = List<int>.from(
      state.listOfSelectedLevelIndexes,
    );

    if (updatedSelection.contains(index)) {
      updatedSelection.remove(index);
    } else {
      updatedSelection.add(index);
    }

    emit(state.copyWith(listOfSelectedLevelIndexes: updatedSelection));
  }

  void addToSelectedLanguageList(int index) {
    List<int> updatedSelection = List<int>.from(
      state.listOfSelectedLanguageIndexes,
    );

    if (updatedSelection.contains(index)) {
      updatedSelection.remove(index);
    } else {
      updatedSelection.add(index);
    }

    emit(state.copyWith(listOfSelectedLanguageIndexes: updatedSelection));
  }

  void changeCertificateSwitch(bool switchValue) {
    emit(state.copyWith(isCertificateSwitchOn: switchValue));
  }

  void isAllItemsShown() {
    emit(state.copyWith(isAllTopicsShown: !state.isAllTopicsShown));
  }

  void changeFreeCourseSwitch(bool switchValue) {
    emit(state.copyWith(isFreeCourseSwitchOn: switchValue));
  }

  void expandBottomSheet(double heightRatio) {
    emit(state.copyWith(heightRatio: heightRatio, isAllTopicsShown: false));
  }

  void controlTopicExpansion(bool val) {
    emit(state.copyWith(isTopicTileOpen: val));
  }

  void controlLevelExpansion(bool val) {
    emit(state.copyWith(isLevelTileOpen: val));
  }

  void controlLanguageExpansion(bool val) {
    emit(state.copyWith(isLanguageTileOpen: val));
  }

  void clearBottomSheetValues() {
    emit(
      state.copyWith(
        isCertificateSwitchOn: false,
        isFreeCourseSwitchOn: false,
        isAllTopicsShown: false,
        isTopicTileOpen: false,
        isLanguageTileOpen: false,
        isLevelTileOpen: false,
        heightRatio: 0.5,
        listOfSelectedTopicIndexes: [],
        listOfSelectedLevelIndexes: [],
        listOfSelectedLanguageIndexes: [],
      ),
    );
  }

  void clearAll() {
    emit(BottomSheetFilterState.initial());
  }

  //!<----------------------- BottomSheet minor  functions end ------------------------------>//
}
