import 'package:edulab_b2b/widget_imports.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.blocProgress == BlocProgress.IS_LOADING) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(child: PrimaryLoader()),
              );
            }

            return Column(
              children: [
                if (state.resultsSubmitted)
                  state.passedTheQuiz
                      ? CongratsWidget(
                          percentage:
                              state.response?.quizInfo.scorePercentage ?? 0,
                        )
                      : TryAgainWidget(
                          percentage:
                              state.response?.quizInfo.scorePercentage ?? 0,
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
                        state.response!.content.isNotEmpty) {
                      try {
                        quizResponse = state.response!.content.firstWhere(
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
                      } else if (quizResponse.status == QuizStatus.incorrect) {
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

                          QuizOptionsWidget(
                            question: question,
                            step: step,
                            currentQuestionRequest: currentQuestionRequest,
                            bgColor: bgColor,
                            icon: icon,
                            state: state,
                          ),
                          SizedBox(height: 10.h),
                          if (state.response!.content.isNotEmpty == true)
                            QuizAnswerTitleWidget(
                              url:
                                  state
                                      .response!
                                      .content[index]
                                      .explanationVideo
                                      ?.originalUrl ??
                                  '',
                            ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),

                if (state.failedTheQuiz)
                  ActionButton(
                    text: context.localizations.retakeQuiz,
                    onTap: () {
                      context.read<QuizBloc>().clearAll();
                    },
                  ),
                if (state.resultsSubmitted == false)
                  ActionButton(
                    isDisabled: !state.isAllSelected,
                    text: context.localizations.submitButton,
                    onTap: () {
                      if (state.isAllSelected &&
                          state.blocProgress != BlocProgress.IS_LOADING) {
                        context.read<QuizBloc>().submitAllQuizzes(
                          step.id,
                        );
                      }
                    },
                  ),

                if (state.passedTheQuiz)
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
    );
  }
}

class TryAgainWidget extends StatelessWidget {
  final double percentage;

  const TryAgainWidget({
    super.key,
    required this.percentage,
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
            context.localizations.youscored(percentage),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class CongratsWidget extends StatelessWidget {
  final double percentage;

  const CongratsWidget({
    super.key,
    required this.percentage,
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
            context.localizations.youhavesuccessfully(percentage),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class QuizAnswerTitleWidget extends StatefulWidget {
  const QuizAnswerTitleWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<QuizAnswerTitleWidget> createState() => _QuizAnswerTitleWidgetState();
}

class _QuizAnswerTitleWidgetState extends State<QuizAnswerTitleWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h),
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
                Flexible(
                  child: AppText.headline1(
                    context.localizations.watchExplanation,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _expanded
              ? Column(
                  children: [
                    SizedBox(height: 10.h),
                    SimpleVideoPlayer(url: widget.url),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
