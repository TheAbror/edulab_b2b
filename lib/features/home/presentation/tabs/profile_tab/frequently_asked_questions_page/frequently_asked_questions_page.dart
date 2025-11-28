import 'package:leti_mobile/widget_imports.dart';

class FrequentlyAskedQuestionsPage extends StatelessWidget {
  const FrequentlyAskedQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileTabPagesAppBar(context, 'Frequently asked questions'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'How to find a course?',
              () {},
            ),
            space16,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'Can I preview a course before purchasing?',
              () {},
            ),
            space16,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'What course features are abailable',
              () {},
            ),
            space16,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'Do I receive anything after I complete a course?',
              () {},
            ),
            space16,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'What is available on Edulab for certification exam preparation?',
              () {},
            ),
            space16,
            ProfileTabSubHeaderWithVerticalSpace(
              context,
              'How do I pay for a course?',
              () {},
            ),
            space16,
          ],
        ),
      ),
    );
  }
}
