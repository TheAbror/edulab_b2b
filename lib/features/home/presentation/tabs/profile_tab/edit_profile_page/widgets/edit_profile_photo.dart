import 'package:leti_mobile/widget_imports.dart';
import 'package:flutter/cupertino.dart';

Center ProfilePhoto(context, String photo) {
  return Center(
    child: GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => ProfileImageDialog(photo: photo),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          ClipOval(
            child: Image.network(
              photo,
              width: 84.w,
              height: 84.w,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showCupertinoModalPopup(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      child: const Text('Upload'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('Edit'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.normal,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ),
              ),
              child: Assets.icons.profile.editAccountIcon.svg(),
            ),
          ),
        ],
      ),
    ),
  );
}
