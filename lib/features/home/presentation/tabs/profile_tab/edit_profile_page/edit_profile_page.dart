import 'package:leti_mobile/widget_imports.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _textFieldFocusNode = FocusNode();
  final db = PreferencesServices.getUserInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: EditProfilePageAppBar(context),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              space20,

              // ProfilePhoto(
              //   context,
              //   db?.profile_photo?.originalUrl ?? '',
              //   db!,
              // ),
              // space24,
              EditProfilePageItem(
                label: 'First name',
                text: db?.firstName ?? '',
                textFieldFocusNode: _textFieldFocusNode,
              ),
              EditProfilePageItem(
                label: 'Last name',
                text: db?.lastName ?? '',
                textFieldFocusNode: _textFieldFocusNode,
              ),
              EditProfilePageItem(
                label: 'Email',
                text: db?.email ?? '',
                textFieldFocusNode: _textFieldFocusNode,
              ),
              EditProfileBiography(textFieldFocusNode: _textFieldFocusNode),
              // space24,
              // ActionButton(
              //   text: 'Save',
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   isDisabled: false,
              // ),
              // SizedBox(height: 250.h),
            ],
          ),
        ),
      ),
    );
  }
}
