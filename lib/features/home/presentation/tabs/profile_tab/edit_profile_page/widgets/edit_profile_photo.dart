import 'package:edulab_b2b/widget_imports.dart';

Center ProfilePhoto(context, String photo, LocalStorageUserInfo db) {
  return Center(
    child: GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) => ProfileImageDialog(photo: photo),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 84.w,
        height: 84.w,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            if (db.profile_photo != null && db.profile_photo?.originalUrl != '')
              ClipOval(
                child: Image.network(
                  photo,
                  width: 84.w,
                  height: 84.w,
                  fit: BoxFit.cover,
                ),
              ),

            if (db.profile_photo == null)
              ClipOval(
                child: defaultAvatarForUserId(db.id).image(
                  width: 84.w,
                  height: 84.w,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
