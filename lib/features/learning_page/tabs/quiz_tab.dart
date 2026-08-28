import 'package:edulab_b2b/widget_imports.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({
    super.key,
    required this.step,
    required this.markAsComplete,
  });

  final StepModel step;
  final VoidCallback markAsComplete;

  /// Score the way the design spells it out: `<correct>/<total>`.
  String _score(QuizState state) {
    final quizInfo = state.response?.quizInfo;
    return '${quizInfo?.correctAnswers ?? 0}/${quizInfo?.totalQuestions ?? 0}';
  }

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
                      ? CongratsWidget(score: _score(state))
                      : TryAgainWidget(score: _score(state)),

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

/// Result banner shown above the questions once the quiz has been submitted.
///
/// Matches the "After finishing the quiz" blocks from Figma: a container tinted
/// with the accent colour at 10%, a Title 2 heading and a Base Text sentence in
/// which the score is highlighted in the accent colour.
class QuizResultBanner extends StatelessWidget {
  const QuizResultBanner({
    super.key,
    required this.title,
    required this.message,
    required this.score,
    required this.accentColor,
  });

  /// Heading of the banner, e.g. "Congratulations! \u{1F389}".
  final String title;

  /// Localised sentence containing [scoreToken] where [score] has to appear.
  final String message;

  /// Score rendered inline, e.g. "80/100".
  final String score;

  /// Colour of both the container tint and the highlighted score.
  final Color accentColor;

  /// Placeholder handed to the localisation so the score can be split out of
  /// the sentence and styled separately. Uses word joiners so it can never
  /// collide with translated copy.
  static const String scoreToken = '\u2060score\u2060';

  @override
  Widget build(BuildContext context) {
    final tokenIndex = message.indexOf(scoreToken);
    final before = tokenIndex == -1 ? message : message.substring(0, tokenIndex);
    final after = tokenIndex == -1
        ? ''
        : message.substring(tokenIndex + scoreToken.length);

    final bodyStyle = TextStyle(
      fontSize: 16.sp,
      height: 20 / 16,
      fontWeight: FontWeight.w400,
      color: context.colors.fgSoft,
    );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              height: 24 / 20,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
              color: context.colors.fgDefault,
            ),
          ),
          SizedBox(height: 6.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: before),
                TextSpan(
                  text: score,
                  style: bodyStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
                TextSpan(text: after),
              ],
            ),
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
        ],
      ),
    );
  }
}

class TryAgainWidget extends StatelessWidget {
  final String score;

  const TryAgainWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return QuizResultBanner(
      title: context.localizations.tryagain,
      message: context.localizations.youscored(QuizResultBanner.scoreToken),
      score: score,
      accentColor: context.colors.errorDefault,
    );
  }
}

class CongratsWidget extends StatelessWidget {
  final String score;

  const CongratsWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return QuizResultBanner(
      title: context.localizations.congratulations,
      message: context.localizations.youhavesuccessfully(
        QuizResultBanner.scoreToken,
      ),
      score: score,
      accentColor: context.colors.successDefault,
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
