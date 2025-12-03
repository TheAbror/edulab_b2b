import 'package:leti_mobile/widget_imports.dart';

class LearningPageTextTab extends StatefulWidget {
  const LearningPageTextTab({
    super.key,
    required this.step,
  });

  final StepModel step;

  @override
  State<LearningPageTextTab> createState() => _LearningPageTextTabState();
}

class _LearningPageTextTabState extends State<LearningPageTextTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<LearningPageBloc, LearningPageState>(
        builder: (context, state) {
          return Column(
            children: [
              HtmlWidget(widget.step.text ?? ''),

              if (widget.step.materials.isNotEmpty)
                state.materialsTabIndex == 0
                    ? CoursesDownloadsTab()
                    : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
