import 'package:leti_mobile/widget_imports.dart';

class LearningTab extends StatelessWidget {
  const LearningTab({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorageUserInfo? db = PreferencesServices.getUserInfo();

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        children: [
          BlocBuilder<LearningTabBloc, LearningTabState>(
            builder: (context, state) {
              final inProgressItem = state.inProgress;
              final completedItem = state.completed;

              return db == null || db.firstName?.isEmpty == true
                  ? UnAuthorizedUser()
                  : Expanded(
                      child: TabBarView(
                        children: [
                          inProgressItem.isEmpty
                              ? NoResultsWidget()
                              : InProgressTab(
                                  item: inProgressItem,
                                  statistics: state.statistics,
                                ),
                          completedItem.isEmpty
                              ? NoResultsWidget()
                              : CompletedTab(item: completedItem),
                        ],
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
