import 'package:edulab_b2b/widget_imports.dart';

class CoursesDownloadsTab extends StatelessWidget {
  const CoursesDownloadsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const AlwaysScrollableScrollPhysics(),
      child: BlocProvider(
        create: (context) => LessonMaterialBloc(
          downloadableMaterialViewModelsList: [
            DownloadableMaterialViewModel(
              name: 'Lecture ',
              src: 'src.docx',
              url: 'url',
              status: DownloadTaskStatus.undefined,
              progress: 1,
            ),
            DownloadableMaterialViewModel(
              name: 'Lecture ',
              src: 'src.ppt',
              url: 'url',
              status: DownloadTaskStatus.complete,
              progress: 1,
            ),
          ],
        ),
        child: BlocBuilder<LessonMaterialBloc, LessonMaterialState>(
          builder: (context, state) {
            return Column(
              children: state.downloadableMaterialViewModelsList
                  .map(
                    (e) => CourseDownloadItem(
                      material: e,
                      localPath: state.localPath ?? '',
                      onPressed: () {},
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
