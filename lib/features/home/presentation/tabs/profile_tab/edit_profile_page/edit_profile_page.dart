import 'package:edulab_b2b/widget_imports.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  LocalStorageUserInfo? db;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    db = PreferencesServices.getUserInfo();
    _bioController = TextEditingController(
      text: PreferencesServices.getProfileBio() ?? '',
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void _removePhoto() {
    final current = db;
    if (current == null) return;

    final updated = LocalStorageUserInfo(
      id: current.id,
      username: current.username,
      firstName: current.firstName,
      lastName: current.lastName,
      account_type_str: current.account_type_str,
      email: current.email,
      phone: current.phone,
      department: current.department,
      jobPosition: current.jobPosition,
      status: current.status,
      profile_photo: null,
    );

    PreferencesServices.saveUserInfo(updated);
    setState(() => db = updated);
  }

  void _onAvatarTypeChanged() {
    setState(() {});
  }

  Future<void> _saveChanges() async {
    await PreferencesServices.saveProfileBio(_bioController.text.trim());

    if (!mounted) return;

    showMessage(context.localizations.changesSaved, context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.localizations;

    return Scaffold(
      backgroundColor: context.colors.bgPage3,
      resizeToAvoidBottomInset: true,
      appBar: EditProfilePageAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        children: [
          EditProfileAvatarRow(
            db: db,
            onRemove: _removePhoto,
            onAvatarTypeChanged: _onAvatarTypeChanged,
          ),

          space24,
          _infoCard(context),

          _card(
            context,
            [EditProfileBiography(controller: _bioController)],
            verticalPadding: 16.h,
          ),
          space24,

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _saveChanges,
            child: Container(
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colors.neutralContainerDefault.withOpacity(0.1),
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                lang.saveChanges,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.16,
                  color: context.colors.neutralOnContainer,
                ),
              ),
            ),
          ),
          space20,
        ],
      ),
    );
  }

  /// "USER INFO" card - read-only view of what the backend returned at login.
  /// Rows with no value are dropped; if nothing is left the card is hidden.
  Widget _infoCard(BuildContext context) {
    final lang = context.localizations;
    final rows = <Widget>[];

    void add(String label, String? value) {
      final trimmed = (value ?? '').trim();
      if (trimmed.isEmpty) return;
      rows.add(EditProfileInfoRow(label: label, value: trimmed));
    }

    add(lang.fullName, '${db?.firstName ?? ''} ${db?.lastName ?? ''}'.trim());
    add(lang.department, db?.department);
    add(lang.position, db?.jobPosition);
    add(lang.email, db?.email);
    add(lang.phoneNumber, db?.phone);
    add(lang.employeeId, db?.username);

    if (rows.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTabHeader(lang.userInfo, context),
        _card(context, rows),
        space12,
      ],
    );
  }

  Widget _card(
    BuildContext context,
    List<Widget> items, {
    double verticalPadding = 0,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: context.colors.bgSurface1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++)
            Container(
              decoration: i == 0
                  ? null
                  : BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: context.colors.borderMuted.withOpacity(0.15),
                        ),
                      ),
                    ),
              child: items[i],
            ),
        ],
      ),
    );
  }
}
