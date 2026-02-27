import 'package:leti_mobile/widget_imports.dart';

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
              Container(
                height: 72.h,
                width: 72.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
