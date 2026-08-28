import 'package:edulab_b2b/widget_imports.dart';

part 'home_state.dart';

enum InternetStatus { connected, disconnected }

class HomeBloc extends Cubit<HomeState> {
  late final StreamSubscription<bool> _subscription;

  HomeBloc() : super(HomeState.initial()) {
    _subscription = ConnectivityService.instance.onStatusChange.listen((
      isConnected,
    ) {
      if (isClosed) return;

      if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        emit(
          state.copyWith(
            internetStatus: isConnected
                ? InternetStatus.connected
                : InternetStatus.disconnected,
          ),
        );
      }
    });

    // The stream only fires on change, so the app launching offline needs its
    // own check to surface the dialog.
    checkConnection();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  Future<void> checkConnection() async {
    final isConnected = await ConnectivityService.instance.hasConnection;

    if (isClosed) return;

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
