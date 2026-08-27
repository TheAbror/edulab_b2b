import 'package:edulab_b2b/widget_imports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CourseShortInfo> _previewCourses() {
  final author = Authors(
    id: 1,
    userId: 1,
    firstname: 'Kristin',
    lastname: 'Watson',
    jobPosition: '',
    about: '',
    courseCount: 0,
  );

  CourseShortInfo course(int id, String category, String title) {
    return CourseShortInfo(
      id: id,
      title: title,
      description: const [],
      short_description: 'desc',
      authors: [author],
      co_authors: const [],
      showPrice: false,
      category: CategoryModel(id: id, title: category),
      progess: 0,
      rating: '4.8',
      learnersCount: 100,
    );
  }

  return [
    course(
      1,
      'Management',
      'Finding Your Professional Voice: Confidence & Impact',
    ),
    course(2, 'Business', 'Project Management'),
    course(
      3,
      'Personal Development',
      'Feedback Loops: How to Give & Receive High-Quality Feedback',
    ),
    course(
      4,
      'Management',
      'Finding Your Professional Voice: Confidence & Impact',
    ),
  ];
}

void main() {
  testWidgets('OurCoursesWidget preview - real device logical size', (
    tester,
  ) async {
    // iPhone 17 simulator physical resolution, dpr 3 -> logical 402x874,
    // intentionally NOT matching the app's ScreenUtil designSize (360x812)
    // to reproduce the width/height scale-factor mismatch a real device has.
    tester.view.physicalSize = const Size(1206, 2622);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    await PreferencesServices.init();

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          theme: lightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            backgroundColor: const Color(0xFFF2F2F5),
            body: OurCoursesWidget(courses: _previewCourses()),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('tmp_our_courses_preview_real.png'),
    );
  });
}
