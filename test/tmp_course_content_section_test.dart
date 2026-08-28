import 'package:edulab_b2b/widget_imports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// Scratch preview: renders ONLY the "Course content" card at 1:1 with the
// design (designSize == viewport, so .w / .h resolve to the Figma numbers) so
// divider tone and type metrics can be compared against Figma node 1623:24257.

const _testColors = CustomColors(
  float: NewColorsLight.staticWhite,
  borderMuted: NewColorsLight.borderMuted,
  borderSoft: NewColorsLight.borderSoft,
  accentMuted: NewColorsLight.accentMuted,
  accentContainerDefault: NewColorsLight.accentContainerDefault,
  accentContainerSoft: NewColorsLight.accentContainerSoft,
  neutralDefault: NewColorsLight.neutralDefault,
  neutralOnContainer: NewColorsLight.neutralOnContainer,
  accentOnContainer: NewColorsLight.accentOnContainer,
  neutralContainerDefault: NewColorsLight.neutralContainerDefault,
  neutralContainerSoft: NewColorsLight.neutralContainerSoft,
  fgMuted: NewColorsLight.fgMuted,
  fgDefault: NewColorsLight.fgDefault,
  fgDisabled: NewColorsLight.fgDisabled,
  fgSoft: NewColorsLight.fgSoft,
  bgPage1: NewColorsLight.bgPage1,
  bgPage2: NewColorsLight.bgPage2,
  bgPage3: NewColorsLight.bgPage3,
  bgSurface1: NewColorsLight.bgSurface1,
  bgSurface3: NewColorsLight.bgSurface3,
  bgSurface4: NewColorsLight.bgSurface4,
  successDefault: NewColorsLight.successDefault,
  infoDefault: NewColorsLight.infoDefault,
  status03ContainerDefault: NewColorsLight.status03ContainerDefault,
  gradientContainer01Start: NewColorsLight.gradientContainer01Start,
  gradientContainer01End: NewColorsLight.gradientContainer01End,
  status06ContainerDefault: NewColorsLight.status06ContainerDefault,
  containerDefault: NewColorsLight.infoContainerDefault,
  accentOnAccent: NewColorsLight.accentOnAccent,
  staticTransparent: NewColorsLight.staticTransparent,
  successContainerDefault: NewColorsLight.successContainerDefault,
  errorContainerDefault: NewColorsLight.errorContainerDefault,
  errorDefault: NewColorsLight.errorDefault,
  errorOnContainer: NewColorsLight.errorOnContainer,
  accentDefault: NewColorsLight.accentDefault,
  neutralContainerActive: NewColorsLight.neutralContainerActive,
  status01OnContainer: NewColorsLight.status01OnContainer,
  status01ContainerDefault: NewColorsLight.status01ContainerDefault,
  neutralMuted: NewColorsLight.neutralMuted,
);

TopicModel _topic(int id, String title) => TopicModel(
  id: id,
  title: title,
  description: '',
  priority: 0,
  status: 'ACTIVE',
  resources: const [],
  steps: const [],
);

const _blurb =
    'Get an introduction to UI and UX Design and the key methodologies such as '
    'Product Design Life Cycle, Double Diamond, and Design Thinking.';

final _chapters = [
  ChapterModel(
    id: 1,
    title: 'Chapter 1 - Introduction to UI/UX Design',
    description: _blurb,
    priority: 0,
    topics: [
      _topic(11, '1.1 Welcome to Introduction to UI and UX Design.'),
      _topic(12, '1.2 What are UI and UX Design?'),
      _topic(13, '1.3 Key Methodologies of UI and UX Design'),
      _topic(14, '1.4 The UI and UX Career Landscape'),
      _topic(15, '1.5 Introduction to UI and UX Design'),
    ],
  ),
  ChapterModel(
    id: 2,
    title: 'Chapter 2 - Wireframes',
    description: _blurb,
    priority: 1,
    topics: [_topic(21, '2.1 Low fidelity wireframes')],
  ),
  ChapterModel(
    id: 3,
    title: 'Chapter 3 - Prototyping with Figma',
    description: _blurb,
    priority: 2,
    topics: [_topic(31, '3.1 Interactive prototypes')],
  ),
];

void main() {
  testWidgets('CourseContentSection matches Figma 1623:24257', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    tester.view.physicalSize = const Size(720, 1900);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 950),
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            extensions: const [_testColors],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Scaffold(
            backgroundColor: NewColorsLight.bgPage3,
            body: SingleChildScrollView(
              child: CourseContentSection(
                chapters: _chapters,
                isCollapsed: false,
                showToggle: true,
                onToggle: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Chapter 1 - Introduction to UI/UX Design'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('tmp_course_content_section.png'),
    );
  });
}
