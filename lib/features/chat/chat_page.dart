import 'package:edulab_b2b/widget_imports.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(),
      body: Stack(
        children: [
          Positioned(bottom: 44.0, left: 0, right: 0, child: ChatTextField()),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(color: context.colors.borderMuted.withOpacity(0.15)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [DiscussionsEmptyWidget()],
          ),
        ],
      ),
    );
  }
}

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: context.colors.neutralContainerDefault.withOpacity(0.1),
      ),
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: context.colors.borderMuted.withOpacity(0.15),
          ),
          color: context.colors.bgSurface1,
        ),
        child: Row(
          children: [
            Assets.icons.chat.emoji.svg(),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                height: 30.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimaryFixed.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: TextFormField(
                  focusNode: FocusNode(),
                  // controller: controller,
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (value) {
                    // sendMessage(context, currentUser);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12.w, bottom: 8.h),
                    border: InputBorder.none,
                    hintText: context.localizations.addComment,
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiaryFixed,
                    ),
                  ),
                ),
              ),
            ),
            Assets.icons.chat.attach.svg(),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {
                // sendMessage(context, currentUser),
              },
              child: Assets.icons.chat.send.svg(),
            ),
          ],
        ),
      ),
    );
  }

  // void sendMessage(BuildContext context, CurrentUser currentUser) {
  //   if (controller.text.isNotEmpty) {
  //     context.read<DiscussionBloc>().postMesssage(
  //           currentUser.userID,
  //           controller.text,
  //           stompClient,
  //         );

  //     controller.text = '';
  //   }
  // }
}

class DiscussionsEmptyWidget extends StatelessWidget {
  const DiscussionsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 155.h),
        Assets.icons.learning.emptyDiscussionIcon.image(
          height: 88.h,
          width: 160.w,
        ),
        space32,
        Text(
          context.localizations.noMessagesYet,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
        ),
        space8,
        SizedBox(
          width: 279.w,
          child: Text(
            context.localizations.startAConversation,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: context.colors.fgMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
