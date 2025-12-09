import 'package:leti_mobile/widget_imports.dart';

class LearningPageBody extends StatefulWidget {
  final TabController controller;
  final List<StepModel> steps;

  const LearningPageBody({
    super.key,
    required this.controller,
    required this.steps,
  });

  @override
  State<LearningPageBody> createState() => LearningPageBodyState();
}

class LearningPageBodyState extends State<LearningPageBody> {
  void completeStep(StepModel stepModel) {
    context.read<LearningBloc>().completeStep(stepModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        return TabBarView(
          controller: widget.controller,
          physics: const BouncingScrollPhysics(),
          children: state.allSteps.map(
            (step) {
              switch (step.type) {
                case 'TEXT':
                  return LearningPageTextTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED" ? () {} : completeStep(step);
                    },
                  );

                case 'VIDEO':
                  return LearningPageVideoTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED" ? () {} : completeStep(step);
                    },
                  );

                case 'QUIZ':
                  return LearningPageQuizTab(
                    step: step,
                    markAsComplete: () {
                      step.status == "COMPLETED" ? () {} : completeStep(step);
                    },
                  );

                default:
                  return SingleChildScrollView(child: Text(step.title));
              }
            },
          ).toList(),
        );
      },
    );
  }
}
