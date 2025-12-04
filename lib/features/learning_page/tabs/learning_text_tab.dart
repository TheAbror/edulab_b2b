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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HtmlWidget(widget.step.text ?? ''),

              Container(
                height: 48.h,
                width: 163.w,
                margin: EdgeInsets.only(top: 24.h),

                decoration: BoxDecoration(
                  color: context.colors.accentDefault,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: AppText.headline1('Mark as complete')),
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
