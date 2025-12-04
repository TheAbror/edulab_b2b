import 'package:leti_mobile/widget_imports.dart';

class LearningTab extends StatelessWidget {
  const LearningTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        children: [
          BlocBuilder<LearningTabBloc, LearningTabState>(
            builder: (context, state) {
              final inProgressItem = state.inProgress;
              final completedItem = state.completed;
              final favoriteItem = state.favorites;

              return Expanded(
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
                    favoriteItem.isEmpty
                        ? NoResultsWidget()
                        : FavoritesTab(item: favoriteItem),
                    NoResultsWidget(),
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
