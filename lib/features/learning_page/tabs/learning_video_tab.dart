import 'package:leti_mobile/widget_imports.dart';

class LearningPageVideoTab extends StatelessWidget {
  final ChewieController? chewieController;
  final StepModel step;

  const LearningPageVideoTab({
    super.key,
    required this.chewieController,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(controller: chewieController!),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),

            child: Column(
              children: [
                const SizedBox(height: 16),

                // Video title
                if (step.title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Video description
                if (step.text?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      step.text!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                const SizedBox(height: 16),

                MarkAsCompleteButton(
                  status: step.status,
                  markAsComplete: () {
                    step.status == "COMPLETED"
                        ? () {}
                        : context.read<LearningBloc>().completeStep(step);
                  },
                ),

                // CoursesDownloadsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
