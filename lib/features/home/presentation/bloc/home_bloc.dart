import 'package:edulab_b2b/widget_imports.dart';

part 'home_state.dart';

enum InternetStatus { connected, disconnected }

class HomeBloc extends Cubit<HomeState> {
  late final StreamSubscription _subscription;

  HomeBloc() : super(HomeState.initial()) {
    _subscription = InternetConnectionChecker.instance.onStatusChange.listen((
      status,
    ) {
      if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        emit(
          state.copyWith(
            internetStatus: status == InternetConnectionStatus.connected
                ? InternetStatus.connected
                : InternetStatus.disconnected,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  Future<void> checkConnection() async {
    final isConnected = await InternetConnectionChecker.instance.hasConnection;

    emit(
      state.copyWith(
        internetStatus: isConnected
            ? InternetStatus.connected
            : InternetStatus.disconnected,
      ),
    );
  }

  initialTheme() {
    final bool? isLight = PreferencesServices.getTheme();
    final returnedNULL = isLight == null;
    final validResult = isLight != null;

    if (returnedNULL) {
      emit(state.copyWith(isLightTheme: true));
    }
    if (validResult) {
      emit(state.copyWith(isLightTheme: isLight));
    }
  }

  void setTheme(bool isLight) {
    PreferencesServices.saveTheme(isLight);

    emit(state.copyWith(isLightTheme: isLight));
  }

  void isDialogShownFirstTime() {
    emit(state.copyWith(isDialogShownFirstTime: false));
  }

  //! < ---------------------------------------------------------->

  void clearAll() {
    emit(HomeState.initial());
  }

  void changeTabIndex(int index) {
    emit(state.copyWith(tabIndex: index));
  }
}
