import 'package:edulab_b2b/widget_imports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Renders the redesigned SingleCourse page (Figma node 1623-22250) to a golden
// so the card layout can be eyeballed without a device / live backend.

class _FakeSingleCourseBloc extends SingleCourseBloc {
  _FakeSingleCourseBloc(SingleCourseState state) {
    emit(state);
  }
}

// The app's CustomColors extension, minus the GoogleFonts-backed ThemeData
// (GoogleFonts can't fetch Inter in the test sandbox).
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

Authors _author(String first, String last, String role, int courses) => Authors(
  id: 1,
  userId: 1,
  firstname: first,
  lastname: last,
  jobPosition: role,
  about:
      '$first is an online entrepreneur who has created 30+ top-rated '
      'educational e-courses on new technology topics such as Artificial '
      'Intelligence, Machine Learning, Deep Learning and Blockchain. So far '
      'more than 1.7 million students have subscribed to these courses.',
  courseCount: courses,
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

// The backend delivers chapters on the top-level `chapters` field (the
// `syllabus.course_content` array comes back empty), so the fixture mirrors that.
final List<ChapterModel> _chapters = [
  ChapterModel(
    id: 1,
    title: 'Chapter 1 - Introduction to UI/UX Design',
    description:
        'Get an introduction to UI and UX Design and the key methodologies '
        'such as Product Design Life Cycle, Double Diamond, and Design '
        'Thinking.',
    priority: 0,
    topics: [
      _topic(11, '1.1 Welcome to Introduction to UI and UX Design.'),
      _topic(12, '1.2 What are UI and UX Design?'),
      _topic(13, '1.3 Key Methodologies of UI and UX Design'),
    ],
  ),
  ChapterModel(
    id: 2,
    title: 'Chapter 2 - Wireframes',
    description:
        'Get an introduction to UI and UX Design and the key methodologies '
        'such as Product Design Life Cycle, Double Diamond, and Design '
        'Thinking.',
    priority: 1,
    topics: [_topic(21, '2.1 Low fidelity wireframes')],
  ),
  ChapterModel(
    id: 3,
    title: 'Chapter 3 - Prototyping with Figma',
    description:
        'Get an introduction to UI and UX Design and the key methodologies '
        'such as Product Design Life Cycle, Double Diamond, and Design '
        'Thinking.',
    priority: 2,
    topics: [_topic(31, '3.1 Interactive prototypes')],
  ),
  ChapterModel(
    id: 4,
    title: 'Chapter 4 - Handoff',
    description: 'Developer handoff and specs.',
    priority: 3,
    topics: [_topic(41, '4.1 Inspect panel')],
  ),
];

SingleCourseInfo _course() => SingleCourseInfo(
  id: 1,
  title: 'Finding Your Professional Voice: Confidence & Impact',
  aboutCourse:
      '<p><b>AS SEEN ON KICKSTARTER</b></p><p>Learn key AI concepts and '
      'intuition training to get you quickly up to speed with all things AI. '
      'Covering:</p><ul><li>How to start building AI with no previous coding '
      'experience using Python</li><li>How to merge AI with OpenAI Gym to learn '
      'as effectively as possible</li><li>How to optimize your AI to reach its '
      'maximum potential in the real world</li></ul>',
  description: const [],
  shortDescription:
      'Get started with User Interface (UI) and User Experience (UX) Design and '
      'learn how to wireframe and prototype using Figma.',
  authors: [
    _author('Darlene', 'Robertson', 'UI/UX Designer', 22),
    _author('Darrell', 'Steward', 'Project Manager', 22),
  ],
  willLearn: const [
    'Strategies for "vertical feedback" to and from people organizationally '
        'above you',
    'Strategies for "vertical feedback" to and from people organizationally '
        'above you (your boss) and people',
    'Strategies for "vertical feedback" to and from people organizationally '
        'above you',
  ],
  co_authors: const [],
  showPrice: false,
  price: '',
  type: CourseType(value: 'BASIC', label: 'Basic'),
  previewVideo: MediaDTO(
    src: '',
    originalName: '',
    url: 'https://example.com/preview.mp4',
    fileSizeStr: '',
    originalUrl: 'https://example.com/preview.mp4',
    thumbUrl: '',
    fileSize: 0,
    extension: 'mp4',
  ),
  skills: [
    LabelValueAsIntResponse(label: 'User Experience (UX)', value: 1),
    LabelValueAsIntResponse(label: 'Prototype', value: 2),
    LabelValueAsIntResponse(label: 'Wireframe', value: 3),
    LabelValueAsIntResponse(label: 'User Experience Design (UXD)', value: 4),
    LabelValueAsIntResponse(label: 'UX Research', value: 5),
    LabelValueAsIntResponse(label: 'mockup', value: 6),
    LabelValueAsIntResponse(label: 'Figma', value: 7),
    LabelValueAsIntResponse(label: 'Usability Testing', value: 8),
  ],
  coAuthorIds: const [],
  learnersCount: 137,
  chapters: _chapters,
  syllabus: SyllabusResponse(courseContent: const []),
);

void main() {
  testWidgets('SingleCourse page preview', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    // 390 x 3400 logical (dpr 3), tall enough to capture the whole scroll view.
    // designSize is scaled to the same aspect ratio so ScreenUtil's .w / .h stay
    // proportional (~1.08x, as on a 390pt device) instead of stretching heights.
    tester.view.physicalSize = const Size(1170, 10200);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    await PreferencesServices.init();

    final state = SingleCourseState.initial().copyWith(
      singleCourse: _course(),
      singleCourseChapters: _chapters,
      blocProgress: BlocProgress.LOADED,
      courseMaterialsAreHidden: true,
      materialsMoreThan3: true,
      isDescriptionHidden: true,
      isRequested: false,
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 3138),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: const ColorScheme.light(
              primary: NewColorsLight.accentDefault,
            ),
            extensions: const [_testColors],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: BlocProvider<SingleCourseBloc>.value(
            value: _FakeSingleCourseBloc(state),
            child: Scaffold(
              backgroundColor: const Color(0xFFEDEDEF),
              body: const SingleCourseBody(isContent: false, id: 1),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // The course-content card is driven by the top-level `chapters` list, not
    // `syllabus.course_content` (which the backend returns empty).
    expect(find.text('Course content'), findsOneWidget);
    expect(
      find.text('Chapter 1 - Introduction to UI/UX Design'),
      findsOneWidget,
    );
    // Only 3 of the 4 chapters show until "Show all" is tapped.
    expect(find.text('Chapter 4 - Handoff'), findsNothing);
    expect(find.text('Show all'), findsWidgets);

    // Expand the first chapter so the golden captures the open accordion too.
    await tester.tap(find.text('Chapter 1 - Introduction to UI/UX Design'));
    await tester.pumpAndSettle();
    expect(
      find.text('1.1 Welcome to Introduction to UI and UX Design.'),
      findsOneWidget,
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('tmp_single_course_preview.png'),
    );
  });
}
