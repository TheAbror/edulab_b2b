import 'package:leti_mobile/widget_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'splash_state.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(SplashState.initial());

  Future<void> setupInitialSettings() async {
    await Future.delayed(const Duration(seconds: 2));

    final String? token = PreferencesServices.getToken();

    ApiProvider.create(token: token ?? '');

    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(authStatus: SplashAuthStatus.authorized));
    } else {
      emit(state.copyWith(authStatus: SplashAuthStatus.notAuthorized));
    }
  }

  void getMinimumAppVersion() async {
    bool showMaintanance = false;
    int minVersion = await PreferencesServices.getMinimumAppVersion() ?? 0;
    int latestAppVersion = await PreferencesServices.getLatestAppVersion() ?? 0;

    emit(state.copyWith(blocProgress: BlocProgress.IS_LOADING));

    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await ApiProvider.appVersionsService.getAppVersions();

      if (response.isSuccessful) {
        final data = response.body;

        if (data != null) {
          showMaintanance = data.showMaintenance;
          minVersion = Platform.isAndroid
              ? data.androidMinVersion
              : data.iosMinVersion;
          latestAppVersion = Platform.isAndroid
              ? data.androidLatestVersion
              : data.iosLatestVersion;

          PreferencesServices.saveShowMaintenance(showMaintanance);
          PreferencesServices.saveMinimumAppVersion(minVersion);
          PreferencesServices.saveLatestAppVersion(latestAppVersion);
          PreferencesServices.saveAppVersionTitle(data.title);
          PreferencesServices.saveAppVersionDescription(data.description);
          PreferencesServices.saveAndroidStoreUrl(data.androidStoreUrl);
          PreferencesServices.saveIOSstoreUrl(data.iosStoreUrl);
          emit(
            state.copyWith(
              appVersionData: data,
              blocProgress: BlocProgress.LOADED,
            ),
          );
        }
      } else {
        final error = ErrorResponse.fromJson(
          json.decode(response.error.toString()),
        );

        emit(
          state.copyWith(
            blocProgress: BlocProgress.FAILED,
            failureMessage: error.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          blocProgress: BlocProgress.FAILED,
          failureMessage: AppStrings.internalErrorMessage,
        ),
      );
    }

    emit(state.copyWith(blocProgress: BlocProgress.LOADED));

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    int buildNumber = int.parse(packageInfo.buildNumber.split('.').last);

    emit(state.copyWith(buildNumber: int.parse(packageInfo.version)));

    if (showMaintanance ||
        buildNumber < minVersion ||
        buildNumber < latestAppVersion) {
      emit(state.copyWith(showAppUpdatesPage: true));
    } else {
      setupInitialSettings();
    }
  }

  void clearAll() {
    emit(SplashState.initial());
  }
}
