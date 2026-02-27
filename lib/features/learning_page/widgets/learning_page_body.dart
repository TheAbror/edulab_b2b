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
          physics: const NeverScrollableScrollPhysics(),
          children: state.allSteps.map(
            (step) {
              return KeyedSubtree(
                key: ValueKey(step.id),
                child: _buildStepTab(step),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget _buildStepTab(StepModel step) {
    switch (step.type) {
      case 'TEXT':
        return LearningPageTextTab(
          step: step,
          markAsComplete: () {
            if (step.status != StepItemStatus.completed) {
              completeStep(step);
            }
          },
        );

      case 'VIDEO':
        return LearningPageVideoTab(
          step: step,
          tabController: widget.controller,
          markAsComplete: () {
            if (step.status != StepItemStatus.completed) {
              completeStep(step);
            }
          },
        );

      case 'QUIZ':
        return QuizTab(
          step: step,
          markAsComplete: () {
            if (step.status != StepItemStatus.completed) {
              completeStep(step);
            }
          },
        );

      default:
        return SingleChildScrollView(child: Text(step.title));
    }
  }
}
