import 'package:leti_mobile/widget_imports.dart';

class LearningPageTextTab extends StatefulWidget {
  const LearningPageTextTab({
    super.key,
    required this.step,
    required this.markAsComplete,
  });

  final StepModel step;
  final VoidCallback markAsComplete;

  @override
  State<LearningPageTextTab> createState() => _LearningPageTextTabState();
}

class _LearningPageTextTabState extends State<LearningPageTextTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<LearningBloc, LearningState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HtmlWidget(widget.step.text ?? ''),

              MarkAsCompleteButton(
                status: widget.step.status,
                markAsComplete: widget.markAsComplete,
              ),

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
