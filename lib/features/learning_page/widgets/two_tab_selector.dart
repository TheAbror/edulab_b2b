import 'package:leti_mobile/widget_imports.dart';

class TwoTabSelector extends StatelessWidget {
  const TwoTabSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        return Container(
          height: 32.h,
          margin: EdgeInsets.only(top: 10.h),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.colors.neutralContainerDefault.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              _buildTab(
                context,
                index: 0,
                text: "Materials",
                state: state,
              ),
              _buildTab(
                context,
                index: 1,
                text: "Chat with teacher",
                state: state,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required int index,
    required String text,
    required LearningState state,
  }) {
    final bool isSelected = state.materialsTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () =>
            context.read<LearningBloc>().changeMaterialsTabIndex(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: AppText.paragraph1(text),
        ),
      ),
    );
  }
}
