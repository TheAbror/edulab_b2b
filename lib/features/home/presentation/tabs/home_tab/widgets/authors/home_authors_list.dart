import 'package:leti_mobile/widget_imports.dart';

class HomeAuthorsList extends StatelessWidget {
  final VoidCallback viewAllOnTap;

  const HomeAuthorsList({super.key, required this.viewAllOnTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              HeadlineAndViewAllWidget(
                text: context.localizations.authors,
                viewAllOnTap: viewAllOnTap,
              ),
              space16,
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.teachers.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = state.teachers[index];
                  return HomeAuthorsItem(
                    onTap: () {
                      // Navigator.pushNamed(context,
                      //   AppRoutes.authorProfilePage,
                      //   extra: '${item.firstname} ${item.lastname}',
                      // );
                      // context.read<HomeBloc>().getTeacherById(item.id);
                    },
                    authorName: '${item.firstname} ${item.lastname}',
                    authorPhoto: item.profile_picture.original_url,
                    position: item.job_title,
                    count: item.courses_number.toString(),
                  );
                },
              ),
              SizedBox(height: 28.h),
            ],
          ),
        );
      },
    );
  }
}
