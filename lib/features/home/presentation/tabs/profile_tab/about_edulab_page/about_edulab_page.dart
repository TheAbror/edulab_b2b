import 'package:edulab_b2b/widget_imports.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutEdulabPage extends StatefulWidget {
  const AboutEdulabPage({super.key});

  @override
  State<AboutEdulabPage> createState() => _AboutEdulabPageState();
}

class _AboutEdulabPageState extends State<AboutEdulabPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (!mounted) return;

    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.localizations;

    return Scaffold(
      backgroundColor: context.colors.bgPage3,
      appBar: profileTabPagesAppBar(context, lang.aboutEdulab),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          children: [
            Assets.icons.main.edulabLogoBig.svg(height: 64.h),
            space24,
            Text(
              'Edulab',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.fgDefault,
              ),
            ),
            space12,
            if (_version.isNotEmpty)
              Text(
                '${lang.appVersion} $_version',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.fgMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
