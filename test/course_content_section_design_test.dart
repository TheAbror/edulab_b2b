import 'package:edulab_b2b/widget_imports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// Pins the "Course content" card to the tokens of Figma node 1623:24257.
//
// The light palette stores `border/soft` and `border/muted` as the bare base
// colour #4E4E5F, with the intended opacity only in a `//25%` / `//15%` code
// comment. Rendering them straight gave near-black rules instead of hairlines,
// so the divider assertions below are the real point of this file.

const _fgDefault = Color(0xFF101013); // foreground/default
const _fgMuted = Color(0xFF71717F); // foreground/muted
const _neutralOnContainer = Color(0xFF1B1B21); // neutral/on-container
const _borderBase = Color(0xFF4E4E5F); // border/soft + border/muted base

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
    topics: [_topic(11, '1.1 Welcome to Introduction to UI and UX Design.')],
  ),
  ChapterModel(
    id: 2,
    title: 'Chapter 2 - Wireframes',
    description: _blurb,
    priority: 1,
    topics: [_topic(21, '2.1 Low fidelity wireframes')],
  ),
];

TextStyle _styleOf(WidgetTester tester, String text) =>
    tester.widget<Text>(find.text(text).first).style!;

/// The horizontal rules drawn between the header, topic list and chapters.
///
/// Rules are one-sided `Border(top:)` / `Border(bottom:)`; the "Show all"
/// outline is a four-sided `Border.all`, so side count tells them apart.
Iterable<BorderSide> _dividerSides(WidgetTester tester) sync* {
  for (final box in tester.widgetList<DecoratedBox>(
    find.descendant(
      of: find.byType(CourseContentSection),
      matching: find.byType(DecoratedBox),
    ),
  )) {
    final decoration = box.decoration;
    if (decoration is! BoxDecoration) continue;
    final border = decoration.border;
    if (border is! Border) continue;

    final solid = [
      border.top,
      border.right,
      border.bottom,
      border.left,
    ].where((side) => side.style == BorderStyle.solid).toList();
    if (solid.length == 1) yield solid.single;
  }
}

Future<void> _pumpCard(WidgetTester tester) async {
  GoogleFonts.config.allowRuntimeFetching = false;

  // designSize == viewport width, so .sp / .w / .h resolve 1:1 to Figma's numbers.
  tester.view.physicalSize = const Size(720, 2400);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 1200),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          extensions: const [_testColors],
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
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
}

void main() {
  testWidgets('dividers use border/soft at 25%, not the bare base colour', (
    tester,
  ) async {
    await _pumpCard(tester);

    final sides = _dividerSides(tester).toList();
    expect(sides, isNotEmpty);

    for (final side in sides) {
      // Regression guard: the base colour rendered solid is near-black.
      expect(
        side.color,
        isNot(_borderBase),
        reason: 'border token must carry its opacity, not render solid',
      );
      expect(side.color.value & 0x00FFFFFF, _borderBase.value & 0x00FFFFFF);
      expect(side.color.opacity, closeTo(0.25, 0.001));
    }
  });

  testWidgets('"Show all" outline uses border/muted at 15%', (tester) async {
    await _pumpCard(tester);

    final button = tester.widget<Container>(
      find
          .ancestor(of: find.text('Show all'), matching: find.byType(Container))
          .first,
    );
    final side = (button.decoration as BoxDecoration).border!.top;

    expect(side.color.value & 0x00FFFFFF, _borderBase.value & 0x00FFFFFF);
    expect(side.color.opacity, closeTo(0.15, 0.001));
  });

  testWidgets('type matches the Base/* text tokens', (tester) async {
    await _pumpCard(tester);

    // Base/Headline 1 — 16 / w500 / lh 20 / ls -0.16
    final title = _styleOf(tester, 'Course content');
    expect(title.fontSize, 16);
    expect(title.height, 20 / 16);
    expect(title.fontWeight, FontWeight.w500);
    expect(title.letterSpacing, -0.16);
    expect(title.color, _fgDefault);

    // Base/Paragraph 1 — 15 / w400 / lh 20
    final chapter = _styleOf(tester, 'Chapter 2 - Wireframes');
    expect(chapter.fontSize, 15);
    expect(chapter.height, 20 / 15);
    expect(chapter.fontWeight, FontWeight.w400);
    expect(chapter.color, _fgDefault);

    // Base/Subhead — 14 / w400 / lh 18 / foreground-muted
    final description = _styleOf(tester, _blurb);
    expect(description.fontSize, 14);
    expect(description.height, 18 / 14);
    expect(description.fontWeight, FontWeight.w400);
    expect(description.color, _fgMuted);

    // Base/Paragraph 2 — 14 / w400 / lh 20
    final topic = _styleOf(tester, '2.1 Low fidelity wireframes');
    expect(topic.fontSize, 14);
    expect(topic.height, 20 / 14);
    expect(topic.fontWeight, FontWeight.w400);
    expect(topic.color, _fgDefault);

    // Base/Paragraph 1 on neutral/on-container
    final showAll = _styleOf(tester, 'Show all');
    expect(showAll.fontSize, 15);
    expect(showAll.height, 20 / 15);
    expect(showAll.color, _neutralOnContainer);
  });
}
