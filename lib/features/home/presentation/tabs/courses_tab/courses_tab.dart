import 'package:edulab_b2b/widget_imports.dart';

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
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.coursesAll.isNotEmpty)
                OurCoursesWidget(
                  isHeaderedNeeded: false,
                  courses: state.coursesAll,
                ),

              space40,
            ],
          );
        },
      ),
    );
  }
}
