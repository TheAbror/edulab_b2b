import 'package:leti_mobile/features/home/presentation/bloc/certificates_bloc.dart';
import 'package:leti_mobile/widget_imports.dart';

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocProvider(
        create: (context) => CertificatesBloc()..getCertificatesByTopicID(),
        // ..getAllTopics(),
        child: BlocBuilder<CertificatesBloc, CertificatesState>(
          builder: (context, state) {
            // if (state.blocProgress == BlocProgress.FAILED) {
            //   return const SomethingWentWrong();
            // }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _categorySelection(state),
                state.blocProgress == BlocProgress.LOADED &&
                        state.certificates.isNotEmpty
                    ? space16
                    : SizedBox.shrink(),

                state.blocProgress == BlocProgress.IS_LOADING
                    ? Expanded(child: PrimaryLoader())
                    : SizedBox.shrink(),

                state.blocProgress != BlocProgress.IS_LOADING &&
                        state.certificates.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No results',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                //
                state.certificates.isNotEmpty &&
                        state.blocProgress == BlocProgress.LOADED
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: state.certificates.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CertificatesItem(
                              text: state.certificates[index].title,
                              certificateUrl: '',
                              grade: 'Grade Achieved: 95.55%',
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBarBackButton(),
          SizedBox(width: 8.w),
          Text(
            'Certificates',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _categorySelection(CertificatesState state) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      margin: EdgeInsets.only(top: 16.w),
      height: 32.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.topics.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              context.read<CertificatesBloc>().changeTabIndex(index);
              context.read<CertificatesBloc>().getCertificatesByTopicID(
                topicId: state.topics[index].id,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: state.tabIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: Text(
                  state.topics[index].name,
                  style: TextStyle(
                    color: state.tabIndex == index
                        ? context.colors.float
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
