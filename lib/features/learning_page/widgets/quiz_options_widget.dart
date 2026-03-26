import 'package:leti_mobile/widget_imports.dart';

class QuizOptionsWidget extends StatelessWidget {
  const QuizOptionsWidget({
    super.key,
    required this.question,
    required this.step,
    required this.currentQuestionRequest,
    required this.bgColor,
    required this.icon,
    required this.state,
  });

  final QuestionModel question;
  final StepModel step;
  final NewQuizAnswers currentQuestionRequest;
  final Color? bgColor;
  final IconData? icon;
  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: question.options.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, innerIndex) {
        final option = question.options[innerIndex];

        final isSelected = state.answersIDS.contains(
          option.id.toString(),
        );

        return Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Ink(
            child: InkWell(
              onTap: () {
                if (state.response?.content.isEmpty == true) {
                  context.read<QuizBloc>().addQuizAnswer(
                    NewQuizAnswers(
                      questionID: question.id,
                      selectedOptionIds: [option.id.toString()],
                    ),
                    step.questions.length,
                  );
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? bgColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colors.borderMuted.withOpacity(0.15),
                    width: 1.w,
                  ),
                ),

                child: Row(
                  children: [
                    Container(
                      height: 24.w,
                      width: 24.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(
                                context,
                              ).colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: context.colors.borderMuted.withOpacity(0.25),
                          width: 2.w,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Icon(
                                isSelected ? icon : Icons.done,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: HtmlWidget(
                        option.text,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
