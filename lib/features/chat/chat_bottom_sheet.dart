import 'package:edulab_b2b/widget_imports.dart';

/// Chat with the course teacher, shown as a bottom sheet over the lesson.
///
/// There is no chat backend yet, so the teacher details are placeholders and
/// the input does not send: the sheet is the empty state until an API exists.
Future<void> showChatBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: context.colors.bgSurface1,
    barrierColor: const Color(0xFF101013).withOpacity(0.7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (_) => const ChatBottomSheet(),
  );
}

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  /// Placeholder teacher until the chat API lands.
  static const _teacherName = 'Saida Rakhmatova';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;

    // The design gives the sheet 737 of an 845pt screen. Cap it at what is
    // actually free so a raised keyboard shrinks the sheet instead of
    // overflowing it.
    final available = media.size.height - keyboard - media.padding.top;
    final desired = media.size.height * 0.87;
    final sheetHeight = desired > available ? available : desired;

    // `useSafeArea` only guards the top of a modal sheet (SafeArea(bottom:
    // false)), so the input has to clear the home indicator itself. A raised
    // keyboard already covers that area, so the inset applies only without one.
    final safeBottom = media.padding.bottom;
    final inputBottomPadding = keyboard > 0
        ? 10.h
        : (safeBottom > 10.h ? safeBottom : 10.h);

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: SizedBox(
        height: sheetHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _Header(),
            const _TeacherRow(name: _teacherName),
            const Expanded(child: _EmptyMessages()),
            _MessageInput(bottomPadding: inputBottomPadding),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.borderMuted.withOpacity(0.15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText.headline1(
              context.localizations.chat,
              color: context.colors.fgDefault,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Icon(
                Icons.close,
                size: 16.r,
                color: context.colors.fgDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeacherRow extends StatelessWidget {
  const _TeacherRow({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.borderMuted.withOpacity(0.15)),
        ),
      ),
      child: Row(
        children: [
          CourseCircleAvatar(imageUrl: '', initials: _initialsFor(name)),
          SizedBox(width: 8.w),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.headline2(
                  name,
                  color: context.colors.fgDefault,
                  maxLines: 1,
                ),
                SizedBox(height: 1.h),
                AppText.caption1(
                  context.localizations.lastSeenRecently,
                  color: context.colors.fgSoft,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            height: 16.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: isDark
                  ? context.colors.neutralDefault
                  : CustomThemes.neutral925,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: AppText.caption3(
              context.localizations.yourTeacher,
              color: context.colors.accentOnAccent,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  String _initialsFor(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty && parts.first.isNotEmpty
        ? parts.first[0]
        : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    final initials = (first + last).toUpperCase();
    return initials.isEmpty ? '—' : initials;
  }
}

class _EmptyMessages extends StatelessWidget {
  const _EmptyMessages();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.learning.emptyDiscussionIcon.image(
              height: 88.h,
              width: 160.w,
            ),
            SizedBox(height: 20.h),
            AppText.title3(
              context.localizations.noMessagesYet,
              color: context.colors.fgDefault,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                context.localizations.startAConversation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 20 / 15,
                  fontWeight: FontWeight.w400,
                  color: context.colors.fgMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({required this.bottomPadding});

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(
      fontSize: 15.sp,
      height: 20 / 15,
      fontWeight: FontWeight.w400,
      color: context.colors.fgSoft,
    );

    return Container(
      color: context.colors.bgSurface1,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 10.h,
        bottom: bottomPadding,
      ),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: context.colors.bgSurface1,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: hintStyle.copyWith(color: context.colors.fgDefault),
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: context.localizations.sendAMessage,
                  hintStyle: hintStyle,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Assets.icons.chat.sendBold.svg(
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                context.colors.fgDefault,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
