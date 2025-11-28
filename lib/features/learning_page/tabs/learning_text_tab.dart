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
              Text(widget.step.text ?? ''),

              // TwoTabSelector(),
              state.materialsTabIndex == 0 ? CoursesDownloadsTab() : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
