import 'package:edulab_b2b/features/home/presentation/tabs/learning_tab/widgets/play_list_items/playlist_text.dart';
import 'package:edulab_b2b/widget_imports.dart';

class PlayListwidget extends StatelessWidget {
  const PlayListwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          double positionY = details.localPosition.dy;
          if (positionY < 0) {
            playListBottomSheet(context);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 60.h,
          width: 400.w,
          padding: EdgeInsets.only(left: 16.w, bottom: 20.h),
          decoration: BoxDecoration(
            color: context.colors.float,
            border: Border(
              top: BorderSide(
                color: context.colors.borderMuted.withOpacity(0.15),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PlayListText(),
              Padding(
                padding: EdgeInsets.only(right: 55.w),
                child: const Icon(Icons.keyboard_arrow_up_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
