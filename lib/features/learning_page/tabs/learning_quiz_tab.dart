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
          child: BlocConsumer<QuizBloc, QuizState>(
            listener: (context, state) {
              // if (state.blocProgress == BlocProgress.IS_LOADING) {
              //   return PrimaryLoader();
              // }
            },
            builder: (context, state) {
              return Column(
                children: [
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
                        } else if (quizResponse.status == "INCORRECT") {
                          bgColor = Colors.red.withOpacity(0.15);
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

                            ListView.builder(
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

                                final isSelected = currentQuestionRequest
                                    .selectedOptionIds
                                    .contains(option.id.toString());

                                return Ink(
                                  child: InkWell(
                                    onTap: () {
                                      context.read<QuizBloc>().addQuizAnswer(
                                        request,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? bgColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: context.colors.borderMuted
                                              .withOpacity(0.15),
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    4,
                                                  ),
                                              border: Border.all(
                                                color: context
                                                    .colors
                                                    .borderMuted
                                                    .withOpacity(
                                                      0.25,
                                                    ),
                                                width: 2.w,
                                              ),
                                            ),
                                            child: isSelected
                                                ? Icon(Icons.done)
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
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

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
