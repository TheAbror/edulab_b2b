import 'package:leti_mobile/widget_imports.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseTabBanner(),
                space40,
                if (state.coursesAll.isNotEmpty)
                  OurCoursesWidget(
                    courses: state.coursesAll,
                    onTapViewAll: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.allCoursesPage,
                      );
                    },
                  ),

                space40,
              ],
            );
          },
        ),
      ),
    );
  }
}
