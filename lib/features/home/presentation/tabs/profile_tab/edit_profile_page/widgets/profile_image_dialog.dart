import 'package:leti_mobile/widget_imports.dart';

class ProfileImageDialog extends StatelessWidget {
  final String photo;

  const ProfileImageDialog({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.network(
        photo,
        width: 300.w,
        height: 300.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
