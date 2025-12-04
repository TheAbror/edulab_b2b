import 'package:leti_mobile/widget_imports.dart';

class LearningPageQuizTab extends StatelessWidget {
  const LearningPageQuizTab({
    super.key,
    required this.step,
  });

  final StepModel step;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc()..setQuizzesCount(step.questions.length),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state.blocProgress == BlocProgress.IS_LOADING) {
                return Center(child: PrimaryLoader());
              }

              return Column(
                children: [
                  if (state.correctnessPercentage != 0)
                    state.correctnessPercentage > 90
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: context.colors.successContainerDefault
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                AppText.title2('Congratulations! 🎉'),
                                AppText.baseText(
                                  'You’ve successfully completed the quiz and scored '
                                  '${state.correctAnswersCount}/${state.overallAnswersCount} '
                                  '(${((state.correctAnswersCount / state.overallAnswersCount) * 100).toStringAsFixed(0)}%)',
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: context.colors.errorContainerDefault
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                AppText.title2('Try Again 💪'),
                                AppText.baseText(
                                  'You scored '
                                  '${state.correctAnswersCount}/${state.overallAnswersCount} '
                                  '(${((state.correctAnswersCount / state.overallAnswersCount) * 100).toStringAsFixed(0)}%)'
                                  ' points and didn’t pass the quiz this time.',
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                  ListView.builder(
                    itemCount: step.questions.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final question = step.questions[index];

                      final currentQuestionRequest = state.quizRequests
                          .firstWhere(
                            (q) => q.questionId == question.id,
                            orElse: () => QuizRequest(
                              questionId: question.id,
                              stepId: step.id,
                              selectedOptionIds: [],
                            ),
                          );

                      Color? bgColor;
                      IconData? icon;

                      QuizResponse? quizResponse;

                      if (state.response != null &&
                          state.response!.isNotEmpty) {
                        try {
                          quizResponse = state.response!.firstWhere(
                            (r) => r.id == question.id,
                          );
                        } catch (_) {
                          quizResponse = null;
                        }
                      }

                      if (quizResponse != null) {
                        if (quizResponse.status == "CORRECT") {
                          bgColor = Colors.green.withOpacity(0.15);
                          icon = Icons.done;
                        } else if (quizResponse.status == "INCORRECT") {
                          bgColor = Colors.red.withOpacity(0.15);
                          icon = Icons.close;
                        }
                      }

                      return Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.colors.borderMuted.withOpacity(0.15),
                            width: 1.w,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          bottom: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HtmlWidget(
                              question.text,
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(height: 16.h),

                            AppText.headline2('Select all correct answers'),

                            SizedBox(height: 12.h),

                            QuizOptionsWidget(
                              question: question,
                              step: step,
                              currentQuestionRequest: currentQuestionRequest,
                              bgColor: bgColor,
                              icon: icon,
                              state: state,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  if (state.correctnessPercentage > 90)
                    ActionButton(text: 'Completed', onTap: () {}),

                  if (state.correctnessPercentage != 0 &&
                      state.correctnessPercentage < 90)
                    ActionButton(
                      text: 'Retake quiz',
                      onTap: () {
                        context.read<QuizBloc>().clearAll();
                      },
                    ),

                  if (state.correctnessPercentage == 0)
                    ActionButton(
                      isDisabled: !state.isAllSelected,
                      text: 'Submit',
                      onTap: () {
                        if (state.isAllSelected &&
                            state.blocProgress != BlocProgress.IS_LOADING) {
                          context.read<QuizBloc>().submitAllQuizzes();
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

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
  final QuizRequest currentQuestionRequest;
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

        final request = QuizRequest(
          questionId: question.id,
          stepId: step.id,
          selectedOptionIds: [option.id.toString()],
        );

        final isSelected = currentQuestionRequest.selectedOptionIds.contains(
          option.id.toString(),
        );

        return Ink(
          child: InkWell(
            onTap: () {
              if (state.response?.isEmpty == true) {
                context.read<QuizBloc>().addQuizAnswer(
                  request,
                );
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 2.h),
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
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                      border: Border.all(
                        color: context.colors.borderMuted.withOpacity(
                          0.25,
                        ),
                        width: 2.w,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            isSelected ? icon : Icons.done,
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
        );
      },
    );
  }
}
