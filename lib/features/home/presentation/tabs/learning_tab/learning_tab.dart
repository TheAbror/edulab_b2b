import 'package:edulab_b2b/widget_imports.dart';

class LearningTab extends StatelessWidget {
  const LearningTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool? isAuthorized = PreferencesServices.getAuthStatus();

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        children: [
          BlocBuilder<LearningTabBloc, LearningTabState>(
            builder: (context, state) {
              final inProgressItem = state.inProgress;
              final completedItem = state.completed;

              return isAuthorized == null
                  ? Expanded(child: UnAuthorizedUser())
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
