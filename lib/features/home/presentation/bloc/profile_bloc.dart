import 'package:leti_mobile/widget_imports.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState.initial());

  // void changeTabIndex(int index) {
  //   emit(state.copyWith(tabIndex: index));
  // }

  void clearAll() {
    emit(ProfileState.initial());
  }
}
