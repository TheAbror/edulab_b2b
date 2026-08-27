import 'package:edulab_b2b/widget_imports.dart';

class FrequentlyAskedQuestionsPage extends StatelessWidget {
  const FrequentlyAskedQuestionsPage({super.key});

  static const _questions = [
    'How to find a course?',
    'Can I preview a course before purchasing?',
    'What course features are abailable',
    'Do I receive anything after I complete a course?',
    'What is available on Edulab for certification exam preparation?',
    'How do I pay for a course?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bgPage3,
      appBar: profileTabPagesAppBar(
        context,
        context.localizations.frequesntlyAskedQuestions,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        children: [
          ProfileTabSectionCard(
            context,
            caption: 'FAQ',
            items: [
              for (final question in _questions)
                ProfileTabSectionItem(
                  context,
                  title: question,
                  maxLines: 2,
                  onTap: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
