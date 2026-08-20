import 'package:edulab_b2b/widget_imports.dart';
import 'search_input.dart';
import 'default_bottom_sheet.dart';
import 'bloc/bottom_sheet_data_bloc.dart';
import 'bottom_sheet_list_single_choice_item.dart';

class PrimaryBottomSheet extends StatelessWidget {
  final String title;
  final double heightRatio;
  final bool isSearchNeeded;
  final bool? isConfirmationNeeded;

  const PrimaryBottomSheet({
    super.key,
    required this.title,
    required this.heightRatio,
    required this.isSearchNeeded,
    required this.isConfirmationNeeded,
  });

  static Future<String?> show(
    BuildContext parentContext, {
    required String title,
    required double heightRatio,
    required bool isSearchNeeded,
    required bool isConfirmationNeeded,
    required String selectedValue,
    required List<String> initialList,
  }) async {
    return showModalBottomSheet<String>(
      backgroundColor: Theme.of(parentContext).colorScheme.background,
      context: parentContext,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => BottomSheetDataBloc(
            initialValue: selectedValue,
            initialList: initialList,
          ),
          child: PrimaryBottomSheet(
            title: title,
            isSearchNeeded: isSearchNeeded,
            isConfirmationNeeded: isConfirmationNeeded,
            heightRatio: heightRatio,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetDataBloc, BottomSheetDataState>(
      builder: (context, state) {
        return DefaultBottomSheet(
          title: title,
          heightRatio: heightRatio,
          isActionEnabled: state.isButtonEnabled,
          actionText: 'Select',
          action: () {
            if (state.isButtonEnabled) {
              Navigator.pop(context, state.selectedValue);
            }
          },
          child: BlocBuilder<BottomSheetDataBloc, BottomSheetDataState>(
            builder: (context, state) {
              if (state.blocProgress == BlocProgress.IS_LOADING) {
                return const PrimaryBottomSheetLoader();
              }

              return _Body(isSearchNeeded: isSearchNeeded);
            },
          ),
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  final bool isSearchNeeded;

  const _Body({required this.isSearchNeeded});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetDataBloc, BottomSheetDataState>(
      builder: (context, state) {
        return Column(
          children: [
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: context.colors.borderMuted.withOpacity(0.15),
            ),

            if (widget.isSearchNeeded)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                child: SearchInput(
                  fillColor: Theme.of(context).colorScheme.surfaceTint,
                  width: double.infinity,
                  hintText: context.localizations.search,
                  prefixIcon: const Icon(Icons.search, color: Colors.amber),
                  controller: searchController,
                  onChanged: (val) {
                    context.read<BottomSheetDataBloc>().search(val);
                  },
                ),
              ),

            Expanded(
              child: BlocBuilder<BottomSheetDataBloc, BottomSheetDataState>(
                builder: (context, state) {
                  if (state.blocProgress == BlocProgress.IS_LOADING) {
                    return const PrimaryLoader();
                  } else if (state.searchedList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: const Text('No Results'),
                    );
                  } else if (state.searchedList.length == 1 &&
                      state.searchedList.first.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: const Text('No Results'),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.searchedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BottomSheetListSingleChoiceItem<String>(
                        itemTitle: state.searchedList[index].toString(),
                        value: state.searchedList[index].toString(),
                        groupValue: state.selectedValue.toString(),
                        onChanged: (value) {
                          context.read<BottomSheetDataBloc>().choose(value);
                          Navigator.pop(context, value);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            // INFO: Always needed for Scrollable Bottom sheets
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}
