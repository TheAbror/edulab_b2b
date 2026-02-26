import 'package:leti_mobile/widget_imports.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({
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
                        ? CongratsWidget(state: state)
                        : TryAgainWidget(state: state),

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

                            AppText.headline2(
                              context.localizations.selectAllCorrectAnswers,
                            ),

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
                                  shape: const Border(),
                                  collapsedShape: const Border(),
                                  title: QuizAnswerTitleWidget(),
                                  trailing: const SizedBox.shrink(),
                                  children: [
                                    SimpleVideoPlayer(
                                      url:
                                          state
                                              .response?[index]
                                              .explanationVideo
                                              ?.originalUrl ??
                                          '',
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  if (state.correctnessPercentage < 90)
                    if (state.correctnessPercentage == -1 ||
                        (state.correctnessPercentage < 90 &&
                            state.correctnessPercentage != 0))
                      ActionButton(
                        text: context.localizations.retakeQuiz,
                        onTap: () {
                          context.read<QuizBloc>().clearAll();
                        },
                      )
                    else
                      ActionButton(
                        isDisabled: !state.isAllSelected,
                        text: context.localizations.submitButton,
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
                  SizedBox(height: 40.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TryAgainWidget extends StatelessWidget {
  final QuizState state;

  const TryAgainWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.errorContainerDefault.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          AppText.title2(context.localizations.tryagain),
          AppText.baseText(
            '${context.localizations.youscored} ${state.correctAnswersCount}/${state.overallAnswersCount} (${((state.correctAnswersCount / state.overallAnswersCount) * 100).toStringAsFixed(0)}%) ${context.localizations.pointsAnd}',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class CongratsWidget extends StatelessWidget {
  final QuizState state;

  const CongratsWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.successContainerDefault.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          AppText.title2(
            context.localizations.congratulations,
          ),
          AppText.baseText(
            '${context.localizations.youhavesuccessfully} ${state.correctAnswersCount}/${state.overallAnswersCount} (${((state.correctAnswersCount / state.overallAnswersCount) * 100).toStringAsFixed(0)}%)',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class QuizAnswerTitleWidget extends StatelessWidget {
  const QuizAnswerTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.learning.videoPlay.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fgDefault,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 6.w),
          AppText.headline1(
            context.localizations.watchExplanation,
          ),
        ],
      ),
    );
  }
}
