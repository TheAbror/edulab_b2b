import 'package:leti_mobile/widget_imports.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _textFieldFocusNode = FocusNode();
  // final CurrentUser? user = userBox.get(ShPrefKeys.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: EditProfilePageAppBar(context),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              space32,
              // if (user?.photo != null && user?.photo != '')
              //   ProfilePhoto(context, user?.photo ?? ''),
              // space24,
              // EditProfilePageItem(
              //   label: 'First name',
              //   text: user?.firstName ?? '',
              //   textFieldFocusNode: _textFieldFocusNode,
              // ),
              // EditProfilePageItem(
              //   label: 'Last name',
              //   text: user?.lastName ?? '',
              //   textFieldFocusNode: _textFieldFocusNode,
              // ),
              // EditProfilePageItem(
              //   label: 'Email',
              //   text: user?.email ?? '',
              //   textFieldFocusNode: _textFieldFocusNode,
              // ),
              EditProfileBiography(textFieldFocusNode: _textFieldFocusNode),
              space24,
              ActionButton(
                text: 'Save',
                onTap: () {
                  Navigator.pop(context);
                },
                isDisabled: false,
              ),
              SizedBox(height: 250.h),
            ],
          ),
        ),
      ),
    );
  }
}
