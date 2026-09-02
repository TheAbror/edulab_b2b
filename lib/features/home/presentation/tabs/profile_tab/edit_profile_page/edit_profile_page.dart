import 'package:edulab_b2b/widget_imports.dart';

/// Marks "leave the photo alone" in [_EditProfilePageState._pushProfile],
/// which has to tell that apart from an explicit null meaning "clear it".
const Object _keepPhoto = Object();

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  LocalStorageUserInfo? db;
  late final TextEditingController _bioController;
  bool _isBusy = false;

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

  /// Gallery -> crop -> disk -> backend.
  ///
  /// The crop is cached locally and shown right away, so a failed upload leaves
  /// the user looking at the photo they chose rather than silently reverting.
  Future<void> _pickPhoto() async {
    if (_isBusy) return;

    final bytes = await pickAndCropAvatar(context);
    if (bytes == null || !mounted) return;

    setState(() => _isBusy = true);

    await ProfilePhotoStorage.save(bytes);
    if (!mounted) return;
    setState(() {});

    final media = await MediaUploadApi.uploadImage(
      bytes,
      fileName: 'avatar.png',
    );

    // `src` is the reference the profile endpoint wants; `url` is the fallback
    // for the odd response that only fills that one in.
    final reference = (media?.src.isNotEmpty ?? false)
        ? media!.src
        : (media?.url.isNotEmpty ?? false)
        ? media!.url
        : null;

    if (reference == null) {
      if (!mounted) return;

      setState(() => _isBusy = false);
      showMessage(context.localizations.photoUploadFailed, context, isError: true);
      return;
    }

    final saved = await _pushProfile(
      photoReference: reference,
      uploadedMedia: media,
    );
    if (!mounted) return;

    setState(() => _isBusy = false);
    if (!saved) {
      showMessage(context.localizations.photoUploadFailed, context, isError: true);
    }
  }

  Future<void> _removePhoto() async {
    if (_isBusy) return;

    setState(() => _isBusy = true);

    await ProfilePhotoStorage.clear();
    if (!mounted) return;

    final saved = await _pushProfile(photoReference: null);
    if (!mounted) return;

    setState(() {
      _isBusy = false;
      db = db?.copyWith(profile_photo: null);
    });

    final current = db;
    if (current != null) await PreferencesServices.saveUserInfo(current);

    if (!saved && mounted) {
      showMessage(context.localizations.somethingWentWrong, context, isError: true);
    }
  }

  void _onAvatarTypeChanged() {
    setState(() {});
  }

  /// `PUT /mobile/profile/` always carries both fields - the backend replaces
  /// what it receives, so sending one alone would clear the other.
  ///
  /// [photoReference] is the string the media upload handed back, or null to
  /// clear the avatar; omit it to resend whatever the account already has.
  ///
  /// [uploadedMedia] is what the upload returned. It stands in when a
  /// successful response doesn't echo `profile_photo` back - without it the
  /// account would look photo-less locally, and the next Save changes would
  /// send null and wipe the avatar server-side.
  Future<bool> _pushProfile({
    Object? photoReference = _keepPhoto,
    MediaDTO? uploadedMedia,
  }) async {
    final reference = identical(photoReference, _keepPhoto)
        ? _currentPhotoReference
        : photoReference as String?;

    try {
      final response = await ApiProvider.profileServices.updateProfile(
        ProfileUpdateRequest(
          aboutMe: _bioController.text.trim(),
          profilePhoto: reference,
        ),
      );

      final body = response.body;
      if (!response.isSuccessful || body == null) return false;

      await PreferencesServices.saveProfileBio(body.aboutMe);

      final current = db;
      if (current != null) {
        final updated = current.copyWith(
          profile_photo: body.profilePhoto ?? uploadedMedia,
        );
        await PreferencesServices.saveUserInfo(updated);
        if (mounted) setState(() => db = updated);
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  /// What the account currently points at, as the API's string form.
  String? get _currentPhotoReference {
    final src = db?.profile_photo?.src;
    return (src == null || src.isEmpty) ? null : src;
  }

  Future<void> _saveChanges() async {
    if (_isBusy) return;

    setState(() => _isBusy = true);

    // Keep the bio locally even if the request fails, so the user's typing
    // isn't thrown away.
    await PreferencesServices.saveProfileBio(_bioController.text.trim());
    final saved = await _pushProfile();

    if (!mounted) return;

    setState(() => _isBusy = false);

    if (!saved) {
      showMessage(context.localizations.somethingWentWrong, context, isError: true);
      return;
    }

    // Stay on the page: popping here tore down the route before BotToast could
    // show the confirmation, since BotToastNavigatorObserver clears toasts on
    // navigation. The user leaves via the back button when they're done.
    showMessage(context.localizations.changesSaved, context);
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
            onPickPhoto: _pickPhoto,
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
              child: _isBusy
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        color: context.colors.neutralOnContainer,
                        strokeWidth: 2.w,
                      ),
                    )
                  : Text(
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
