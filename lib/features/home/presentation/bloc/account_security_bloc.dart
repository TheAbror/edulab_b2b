import 'package:leti_mobile/widget_imports.dart';

part 'account_security_state.dart';

class AccountSecurityBloc extends Cubit<AccountSecurityState> {
  AccountSecurityBloc() : super(AccountSecurityState.initial());

  void changeShowProfileInfo(bool value) {
    emit(state.copyWith(showProfileInfo: value));
  }

  void changeShowCoursesInfo(bool value) {
    emit(state.copyWith(showCoursesInfo: value));
  }
}
