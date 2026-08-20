import 'package:edulab_b2b/widget_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdatesView extends StatefulWidget {
  const AppUpdatesView({super.key});

  @override
  State<AppUpdatesView> createState() => _AppUpdatesViewState();
}

class _AppUpdatesViewState extends State<AppUpdatesView> {
  int buildNumber = 1;
  bool showMaintenance = false;
  int latestAppVersion = 1;
  String title = '';
  String description = '';
  String androidStoreUrl = '';
  String iosStoreUrl = '';

  @override
  void initState() {
    getAppVersions();

    super.initState();
  }

  void getAppVersions() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    buildNumber = int.parse(packageInfo.buildNumber);

    showMaintenance = await PreferencesServices.getShowMaintenance() ?? false;
    latestAppVersion = await PreferencesServices.getLatestAppVersion() ?? 1;
    title = await PreferencesServices.getAppVersionTitle() ?? '';
    description = await PreferencesServices.getAppVersionDescription() ?? '';
    androidStoreUrl = await PreferencesServices.getAndroidStoreUrl() ?? '';
    iosStoreUrl = await PreferencesServices.getIOSstoreUrl() ?? '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Spacer(flex: 2),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Assets.icons.letiLogoPng.image(
                  width: 260.w,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  showMaintenance
                      ? GestureDetector(
                          child: Assets.images.maintenance.svg(width: 170.w),
                        )
                      : Platform.isAndroid
                      ? Assets.images.googlePlay.image(width: 80.w)
                      : Assets.images.iosAppStore.image(width: 80.w),
                  SizedBox(height: 40.h),
                  if (showMaintenance)
                    Text(
                      context.localizations.maintenanceInProgress,
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  if (!showMaintenance)
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  SizedBox(height: 10.h),
                  if (!showMaintenance)
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (!showMaintenance)
            Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: Column(
                children: [
                  ActionButton(
                    text: context.localizations.updateNow.toUpperCase(),
                    onTap: () => openUrl(
                      Platform.isAndroid ? androidStoreUrl : iosStoreUrl,
                    ),
                  ),
                  if (buildNumber < latestAppVersion)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ActionButton(
                        isFilled: false,
                        text: context.localizations.notNow.toUpperCase(),
                        onTap: () {
                          context.read<SplashBloc>().setupInitialSettings();
                        },
                      ),
                    ),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> openUrl(String url) async {
  try {
    final Uri parsedUrl = Uri.parse(url);

    if (await canLaunchUrl(parsedUrl)) {
      if (!await launchUrl(parsedUrl)) {
        throw Exception('Could not launch $parsedUrl');
      }
    } else {
      throw Exception('Invalid URL: $parsedUrl');
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}
