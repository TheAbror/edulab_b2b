import 'package:leti_mobile/widget_imports.dart';

class LearningPageQuizTab extends StatelessWidget {
  const LearningPageQuizTab({
    super.key,
    required this.step,
    required this.markAsComplete,
  });

  final StepModel step;
  final VoidCallback markAsComplete;

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

                      final currentQuestionRequest = state.quizRequests.answers
                          .firstWhere(
                            (q) => q.questionID == question.id,
                            orElse: () => NewQuizAnswers.initial(),
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
                        if (quizResponse.status == QuizStatus.correct) {
                          bgColor = Colors.green.withOpacity(0.15);
                          icon = Icons.done;
                        } else if (quizResponse.status ==
                            QuizStatus.incorrect) {
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
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: HtmlWidget(
                                    question.text,
                                    textStyle: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                              ],
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
                            if (state.response?.isNotEmpty == true)
                              // Container(
                              //   padding: EdgeInsets.symmetric(vertical: 14.h),
                              //   decoration: BoxDecoration(
                              //     color: context.colors.neutralContainerDefault
                              //         .withOpacity(0.1),
                              //     borderRadius: BorderRadius.circular(100),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Assets.icons.learning.videoPlay.svg(
                              //         colorFilter: ColorFilter.mode(
                              //           context.colors.fgDefault,
                              //           BlendMode.srcIn,
                              //         ),
                              //       ),
                              //       SizedBox(width: 6.w),
                              //       AppText.headline1('Watch explanation'),
                              //     ],
                              //   ),
                              // ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  dividerColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  leading: const SizedBox.shrink(),
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.zero,
                                  minTileHeight: 0,
                                  shape:
                                      const Border(), // ← removes default border on expand
                                  collapsedShape: const Border(),
                                  title: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context
                                          .colors
                                          .neutralContainerDefault
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Assets.icons.learning.videoPlay.svg(
                                          colorFilter: ColorFilter.mode(
                                            context.colors.fgDefault,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        AppText.headline1('Watch explanation'),
                                      ],
                                    ),
                                  ),
                                  trailing: const SizedBox.shrink(),
                                  children: [
                                    Text('data'),
                                    Text('data'),
                                    Text('data'),
                                    Text('data'),
                                    Text('data'),
                                  ],
                                ),
                              ),
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
                          context.read<QuizBloc>().submitAllQuizzes(step.id);
                        }
                      },
                    ),

                  if (state.correctnessPercentage > 90)
                    MarkAsCompleteButton(
                      status: step.status,
                      markAsComplete: markAsComplete,
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

        // final request = NewQuizRequest(
        //   questionId: question.id,
        //   stepId: step.id,
        //   selectedOptionIds: [option.id.toString()],
        // );

        final isSelected = state.answersIDS.contains(
          option.id.toString(),
        );

        return Ink(
          child: InkWell(
            onTap: () {
              if (state.response?.isEmpty == true) {
                context.read<QuizBloc>().addQuizAnswer(
                  NewQuizAnswers(
                    questionID: question.id,
                    selectedOptionIds: [option.id.toString()],
                  ),
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
        );
      },
    );
  }
}
