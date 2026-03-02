import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @enterYourCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to access the platform'**
  String get enterYourCredentials;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @idText.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get idText;

  /// No description provided for @inCorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get inCorrect;

  /// No description provided for @internalError.
  ///
  /// In en, this message translates to:
  /// **'Internal error'**
  String get internalError;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @timetable.
  ///
  /// In en, this message translates to:
  /// **'Timetable'**
  String get timetable;

  /// No description provided for @marks.
  ///
  /// In en, this message translates to:
  /// **'Marks'**
  String get marks;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get editProfile;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @libraryButton.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryButton;

  /// No description provided for @faceID.
  ///
  /// In en, this message translates to:
  /// **'FaceID security'**
  String get faceID;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @noModulesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Modules available'**
  String get noModulesAvailable;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @yourModules.
  ///
  /// In en, this message translates to:
  /// **'Your modules'**
  String get yourModules;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @module.
  ///
  /// In en, this message translates to:
  /// **'Module'**
  String get module;

  /// No description provided for @absentHours.
  ///
  /// In en, this message translates to:
  /// **'Absent hours'**
  String get absentHours;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get course;

  /// No description provided for @academicYear.
  ///
  /// In en, this message translates to:
  /// **'Academic year'**
  String get academicYear;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @overallMark.
  ///
  /// In en, this message translates to:
  /// **'Overal Mark'**
  String get overallMark;

  /// No description provided for @onlineLearning.
  ///
  /// In en, this message translates to:
  /// **'Online learning'**
  String get onlineLearning;

  /// No description provided for @documentsWithCapital.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsWithCapital;

  /// No description provided for @noLessonsAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No lessons added yet'**
  String get noLessonsAddedYet;

  /// No description provided for @noOnlineLessonsAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No online lessons added yet'**
  String get noOnlineLessonsAddedYet;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'ALL'**
  String get all;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'VIDEO'**
  String get video;

  /// No description provided for @noFilesToDownload.
  ///
  /// In en, this message translates to:
  /// **'No files to download'**
  String get noFilesToDownload;

  /// No description provided for @noVideoFilesToDownload.
  ///
  /// In en, this message translates to:
  /// **'No video files available'**
  String get noVideoFilesToDownload;

  /// No description provided for @noDocumentsToDownload.
  ///
  /// In en, this message translates to:
  /// **'No documents available'**
  String get noDocumentsToDownload;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filterByCategory.
  ///
  /// In en, this message translates to:
  /// **'Filter by category'**
  String get filterByCategory;

  /// No description provided for @passcodeWasRemoved.
  ///
  /// In en, this message translates to:
  /// **'Passcode was removed'**
  String get passcodeWasRemoved;

  /// No description provided for @turnPasscodeOn.
  ///
  /// In en, this message translates to:
  /// **'Turn passcode on'**
  String get turnPasscodeOn;

  /// No description provided for @changePasscode.
  ///
  /// In en, this message translates to:
  /// **'Change Passcode'**
  String get changePasscode;

  /// No description provided for @enterNewPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter new passcode'**
  String get enterNewPasscode;

  /// No description provided for @confirmNewPasscode.
  ///
  /// In en, this message translates to:
  /// **'Confirm new passcode'**
  String get confirmNewPasscode;

  /// No description provided for @passcodeWasSuccessfullyChanged.
  ///
  /// In en, this message translates to:
  /// **'Passcode was successfully changed'**
  String get passcodeWasSuccessfullyChanged;

  /// No description provided for @passcodesDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passcodes do not match'**
  String get passcodesDoNotMatch;

  /// No description provided for @passcodeWasSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Passcode was successfully created'**
  String get passcodeWasSuccessfullyCreated;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out?'**
  String get signOut;

  /// No description provided for @doYouWannaSignOut.
  ///
  /// In en, this message translates to:
  /// **'Do you want to sign out from the system'**
  String get doYouWannaSignOut;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get documentType;

  /// No description provided for @documentNumber.
  ///
  /// In en, this message translates to:
  /// **'Document number'**
  String get documentNumber;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @editText.
  ///
  /// In en, this message translates to:
  /// **'Edit (short)'**
  String get editText;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @pleaseEnterValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter value'**
  String get pleaseEnterValue;

  /// No description provided for @editTextFull.
  ///
  /// In en, this message translates to:
  /// **'Edit (full)'**
  String get editTextFull;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @noResultsText.
  ///
  /// In en, this message translates to:
  /// **'No Results'**
  String get noResultsText;

  /// No description provided for @finalGrade.
  ///
  /// In en, this message translates to:
  /// **'Final Grade'**
  String get finalGrade;

  /// No description provided for @enterCurrentPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter current passcode'**
  String get enterCurrentPasscode;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @incorrectPasscode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect passcode'**
  String get incorrectPasscode;

  /// No description provided for @enterPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter passcode'**
  String get enterPasscode;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @pleaseEnterID.
  ///
  /// In en, this message translates to:
  /// **'Please enter your student id'**
  String get pleaseEnterID;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @timetableGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get timetableGroup;

  /// No description provided for @timetableTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get timetableTeacher;

  /// No description provided for @timetableRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get timetableRoom;

  /// No description provided for @academicYearSelection.
  ///
  /// In en, this message translates to:
  /// **'Select Academic year'**
  String get academicYearSelection;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @errorOccured.
  ///
  /// In en, this message translates to:
  /// **'error occurred'**
  String get errorOccured;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// No description provided for @editInquiry.
  ///
  /// In en, this message translates to:
  /// **'Edit an inquiry'**
  String get editInquiry;

  /// No description provided for @createInquiry.
  ///
  /// In en, this message translates to:
  /// **'Create an inquiry'**
  String get createInquiry;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @pleaseEnterTitleAndDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter title and description of the inquiry'**
  String get pleaseEnterTitleAndDescription;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @recepient.
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recepient;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'STAFF'**
  String get staff;

  /// No description provided for @recepientGroup.
  ///
  /// In en, this message translates to:
  /// **'Recipient group'**
  String get recepientGroup;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @selectUnit.
  ///
  /// In en, this message translates to:
  /// **'Select Unit'**
  String get selectUnit;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @actionButton.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get actionButton;

  /// No description provided for @changeLog.
  ///
  /// In en, this message translates to:
  /// **'Change log'**
  String get changeLog;

  /// No description provided for @involvedUsers.
  ///
  /// In en, this message translates to:
  /// **'Involved users'**
  String get involvedUsers;

  /// No description provided for @staffFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get staffFrom;

  /// No description provided for @staffTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get staffTo;

  /// No description provided for @filterByStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter by status'**
  String get filterByStatus;

  /// No description provided for @meetingDate.
  ///
  /// In en, this message translates to:
  /// **'Meeting date'**
  String get meetingDate;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @newxtWeek.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get newxtWeek;

  /// No description provided for @saveAsTemplate.
  ///
  /// In en, this message translates to:
  /// **'Save as template'**
  String get saveAsTemplate;

  /// No description provided for @quickReply.
  ///
  /// In en, this message translates to:
  /// **'Quick reply'**
  String get quickReply;

  /// No description provided for @inspector.
  ///
  /// In en, this message translates to:
  /// **'Inspector'**
  String get inspector;

  /// No description provided for @selectRecipient.
  ///
  /// In en, this message translates to:
  /// **'Select recipient'**
  String get selectRecipient;

  /// No description provided for @removeButton.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeButton;

  /// No description provided for @chooseAction.
  ///
  /// In en, this message translates to:
  /// **'Choose Action'**
  String get chooseAction;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @selectUser.
  ///
  /// In en, this message translates to:
  /// **'Select User'**
  String get selectUser;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @selectButton.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @cantbeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Can’t be empty'**
  String get cantbeEmpty;

  /// No description provided for @inquiryWasSuccessfullyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Inquiry was successfully deleted'**
  String get inquiryWasSuccessfullyDeleted;

  /// No description provided for @inquiryUpdated.
  ///
  /// In en, this message translates to:
  /// **'Inquiry successfully updated'**
  String get inquiryUpdated;

  /// No description provided for @inquiryCommentPosted.
  ///
  /// In en, this message translates to:
  /// **'Comment template is successfully created!'**
  String get inquiryCommentPosted;

  /// No description provided for @errorHappened.
  ///
  /// In en, this message translates to:
  /// **'Error happened'**
  String get errorHappened;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'MON'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'TUE'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'WED'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'THU'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'FRI'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get sat;

  /// No description provided for @selectValue.
  ///
  /// In en, this message translates to:
  /// **'Select value'**
  String get selectValue;

  /// No description provided for @staffSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get staffSettings;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @ifFormatNotSupported.
  ///
  /// In en, this message translates to:
  /// **'If format is not supported, long press on the icon'**
  String get ifFormatNotSupported;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @credits.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get credits;

  /// No description provided for @semester.
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get semester;

  /// No description provided for @aboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutTheApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appName;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @customizableLMS.
  ///
  /// In en, this message translates to:
  /// **'Customizable LMS for Universities'**
  String get customizableLMS;

  /// No description provided for @ourWebsite.
  ///
  /// In en, this message translates to:
  /// **'Our website'**
  String get ourWebsite;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @fieldsCantbeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Fields can’t be empty'**
  String get fieldsCantbeEmpty;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @canteen.
  ///
  /// In en, this message translates to:
  /// **'Canteen'**
  String get canteen;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'e-Shop'**
  String get shop;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @featureWillBeAvailableSoon.
  ///
  /// In en, this message translates to:
  /// **'Feature will be available soon'**
  String get featureWillBeAvailableSoon;

  /// No description provided for @shopSizes.
  ///
  /// In en, this message translates to:
  /// **'Sizes'**
  String get shopSizes;

  /// No description provided for @shopColors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get shopColors;

  /// No description provided for @downloadStudyMaterials.
  ///
  /// In en, this message translates to:
  /// **'Download study materials and e-books.'**
  String get downloadStudyMaterials;

  /// No description provided for @attendanceHistory.
  ///
  /// In en, this message translates to:
  /// **'Attendance history'**
  String get attendanceHistory;

  /// No description provided for @trackAttendanceRecords.
  ///
  /// In en, this message translates to:
  /// **'Track attendance records.'**
  String get trackAttendanceRecords;

  /// No description provided for @viewCanteenMenu.
  ///
  /// In en, this message translates to:
  /// **'View canteen menu and prices.'**
  String get viewCanteenMenu;

  /// No description provided for @buyStudyMaterials.
  ///
  /// In en, this message translates to:
  /// **'Buy study materials and accessories.'**
  String get buyStudyMaterials;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Discussion’s topics'**
  String get topics;

  /// No description provided for @discussion.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussion;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get addComment;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @startAConversation.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation with your teacher. Ask questions, share updates.'**
  String get startAConversation;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @moduleCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get moduleCode;

  /// No description provided for @inquiriesTab.
  ///
  /// In en, this message translates to:
  /// **'Inquiries'**
  String get inquiriesTab;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @viewYourPaymentData.
  ///
  /// In en, this message translates to:
  /// **'View your payment data'**
  String get viewYourPaymentData;

  /// No description provided for @debitTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total amount'**
  String get debitTotalAmount;

  /// No description provided for @debitPaidAmount.
  ///
  /// In en, this message translates to:
  /// **'Paid amount'**
  String get debitPaidAmount;

  /// No description provided for @debitRemainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining amount'**
  String get debitRemainingAmount;

  /// No description provided for @paymentAcademicYear.
  ///
  /// In en, this message translates to:
  /// **'Academic year'**
  String get paymentAcademicYear;

  /// No description provided for @paymentDebit.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get paymentDebit;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get paymentStatus;

  /// No description provided for @paymentsDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get paymentsDetails;

  /// No description provided for @paymentMainContractAmount.
  ///
  /// In en, this message translates to:
  /// **'Main contract amount'**
  String get paymentMainContractAmount;

  /// No description provided for @paymentsSuperContractAmount.
  ///
  /// In en, this message translates to:
  /// **'Super contract amount'**
  String get paymentsSuperContractAmount;

  /// No description provided for @paymentsParts.
  ///
  /// In en, this message translates to:
  /// **'Parts'**
  String get paymentsParts;

  /// No description provided for @paymentsDeadline.
  ///
  /// In en, this message translates to:
  /// **'Payment deadline'**
  String get paymentsDeadline;

  /// No description provided for @contractName.
  ///
  /// In en, this message translates to:
  /// **'Contract name'**
  String get contractName;

  /// No description provided for @modules.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get modules;

  /// No description provided for @noTopicsWereCreatedYet.
  ///
  /// In en, this message translates to:
  /// **'No topics have been created yet'**
  String get noTopicsWereCreatedYet;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filterByWeek.
  ///
  /// In en, this message translates to:
  /// **'Filter by week'**
  String get filterByWeek;

  /// No description provided for @teachingWeek.
  ///
  /// In en, this message translates to:
  /// **'Teaching week'**
  String get teachingWeek;

  /// No description provided for @signInWith.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get signInWith;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'May be later'**
  String get maybeLater;

  /// No description provided for @byUsingThisApp.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to our Terms and Conditions.'**
  String get byUsingThisApp;

  /// No description provided for @cities.
  ///
  /// In en, this message translates to:
  /// **'Cities'**
  String get cities;

  /// No description provided for @places.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get places;

  /// No description provided for @usefulApps.
  ///
  /// In en, this message translates to:
  /// **'Useful apps'**
  String get usefulApps;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @startYourAdventure.
  ///
  /// In en, this message translates to:
  /// **'Start your adventure along the Silk Road — discover the wonders of Uzbekistan!'**
  String get startYourAdventure;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createYourAccount;

  /// No description provided for @cantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Can’t be empty'**
  String get cantBeEmpty;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @weWillSendYouACode.
  ///
  /// In en, this message translates to:
  /// **'We’ll send you a code to reset your password'**
  String get weWillSendYouACode;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enterCode;

  /// No description provided for @weHaveSentYou.
  ///
  /// In en, this message translates to:
  /// **'We have sent a code to'**
  String get weHaveSentYou;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordMustContain.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 5 letters'**
  String get passwordMustContain;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// No description provided for @passwordReset.
  ///
  /// In en, this message translates to:
  /// **'Password reset'**
  String get passwordReset;

  /// No description provided for @didnotGetIt.
  ///
  /// In en, this message translates to:
  /// **'Didn’t get it?'**
  String get didnotGetIt;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get sendAgain;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @signInNow.
  ///
  /// In en, this message translates to:
  /// **'Sign in now'**
  String get signInNow;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @skipStep.
  ///
  /// In en, this message translates to:
  /// **'Skip step'**
  String get skipStep;

  /// No description provided for @tellUsAboutY.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutY;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @welcomeToLetiEdu.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Leti School!'**
  String get welcomeToLetiEdu;

  /// No description provided for @trackYourLearning.
  ///
  /// In en, this message translates to:
  /// **'Track your learning progress, personalize your experience and earn achievements'**
  String get trackYourLearning;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signin;

  /// No description provided for @skipfornow.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipfornow;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get homeTab;

  /// No description provided for @learingTab.
  ///
  /// In en, this message translates to:
  /// **'LEARNING'**
  String get learingTab;

  /// No description provided for @coursesTab.
  ///
  /// In en, this message translates to:
  /// **'COURSES'**
  String get coursesTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get profileTab;

  /// No description provided for @welcometoEdulab.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Edulab'**
  String get welcometoEdulab;

  /// No description provided for @trackyourlearning.
  ///
  /// In en, this message translates to:
  /// **'Track your learning progress, personalize your experience and earn achievements'**
  String get trackyourlearning;

  /// No description provided for @createanaccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createanaccount;

  /// No description provided for @createayourccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createayourccount;

  /// No description provided for @skipforNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipforNow;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @bysignningAgree.
  ///
  /// In en, this message translates to:
  /// **'By signing up you agree to Edulab’s Terms of Service and Privacy Policy.'**
  String get bysignningAgree;

  /// No description provided for @existinguser.
  ///
  /// In en, this message translates to:
  /// **'Existing user'**
  String get existinguser;

  /// No description provided for @buildskillsfortodayetc.
  ///
  /// In en, this message translates to:
  /// **'Build skills for today, tomorrow, and beyond. Education to future-proof your career.'**
  String get buildskillsfortodayetc;

  /// No description provided for @phonenumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phonenumber;

  /// No description provided for @continuewithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continuewithGoogle;

  /// No description provided for @entercode.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get entercode;

  /// No description provided for @wehavesentyoucodeto.
  ///
  /// In en, this message translates to:
  /// **'We have sent you code to'**
  String get wehavesentyoucodeto;

  /// No description provided for @resetafter.
  ///
  /// In en, this message translates to:
  /// **'Reset after'**
  String get resetafter;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @resendcode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendcode;

  /// No description provided for @firstname.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstname;

  /// No description provided for @lastname.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastname;

  /// No description provided for @emailaddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailaddress;

  /// No description provided for @skipstep.
  ///
  /// In en, this message translates to:
  /// **'Skip step'**
  String get skipstep;

  /// No description provided for @startlearning.
  ///
  /// In en, this message translates to:
  /// **'Start learning'**
  String get startlearning;

  /// No description provided for @donthaveanaccountyet.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account yet?'**
  String get donthaveanaccountyet;

  /// No description provided for @forgotpassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotpassword;

  /// No description provided for @cantbeempty.
  ///
  /// In en, this message translates to:
  /// **'Can’t be empty'**
  String get cantbeempty;

  /// No description provided for @enteryouremailorphone.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone'**
  String get enteryouremailorphone;

  /// No description provided for @wellsendyou.
  ///
  /// In en, this message translates to:
  /// **'We’ll send you a link or code to reset your password'**
  String get wellsendyou;

  /// No description provided for @checkyouremailandopen.
  ///
  /// In en, this message translates to:
  /// **'Check your email and open the link we sent to continue'**
  String get checkyouremailandopen;

  /// No description provided for @didntgetit.
  ///
  /// In en, this message translates to:
  /// **'Didn’t get it?'**
  String get didntgetit;

  /// No description provided for @sendmeanewemail.
  ///
  /// In en, this message translates to:
  /// **'Send me a new email'**
  String get sendmeanewemail;

  /// No description provided for @newpassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newpassword;

  /// No description provided for @repeatpassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatpassword;

  /// No description provided for @changepassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changepassword;

  /// No description provided for @passwordreset.
  ///
  /// In en, this message translates to:
  /// **'Password reset'**
  String get passwordreset;

  /// No description provided for @signinnow.
  ///
  /// In en, this message translates to:
  /// **'Sign in now'**
  String get signinnow;

  /// No description provided for @numberShouldStart.
  ///
  /// In en, this message translates to:
  /// **'Number should start with 998'**
  String get numberShouldStart;

  /// No description provided for @pleaseEnterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get pleaseEnterValidPhoneNumber;

  /// No description provided for @myStudy.
  ///
  /// In en, this message translates to:
  /// **'My Study'**
  String get myStudy;

  /// No description provided for @courseProgress.
  ///
  /// In en, this message translates to:
  /// **'Course progress'**
  String get courseProgress;

  /// No description provided for @tellUsAboutYrself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutYrself;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended For You'**
  String get recommendedForYou;

  /// No description provided for @authors.
  ///
  /// In en, this message translates to:
  /// **'Authors'**
  String get authors;

  /// No description provided for @coursesWithnumber.
  ///
  /// In en, this message translates to:
  /// **'courses'**
  String get coursesWithnumber;

  /// No description provided for @softSkills.
  ///
  /// In en, this message translates to:
  /// **'Soft Skills'**
  String get softSkills;

  /// No description provided for @learnNewSkills.
  ///
  /// In en, this message translates to:
  /// **'Learn new skills'**
  String get learnNewSkills;

  /// No description provided for @proveYourPotential.
  ///
  /// In en, this message translates to:
  /// **'Prove your potential.'**
  String get proveYourPotential;

  /// No description provided for @viewAllCourses.
  ///
  /// In en, this message translates to:
  /// **'View all courses'**
  String get viewAllCourses;

  /// No description provided for @itLooksLikeUJNotEnroller.
  ///
  /// In en, this message translates to:
  /// **'It looks like you’re not enrolled in any courses. Get started by finding something to learn'**
  String get itLooksLikeUJNotEnroller;

  /// No description provided for @findsomethingToLearn.
  ///
  /// In en, this message translates to:
  /// **'Find something to learn'**
  String get findsomethingToLearn;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAll;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @tryForFree.
  ///
  /// In en, this message translates to:
  /// **'Try for free'**
  String get tryForFree;

  /// No description provided for @courseMaterials.
  ///
  /// In en, this message translates to:
  /// **'Course materials'**
  String get courseMaterials;

  /// No description provided for @whatUWillLearn.
  ///
  /// In en, this message translates to:
  /// **'What you’ll learn'**
  String get whatUWillLearn;

  /// No description provided for @certificateOfCompletion.
  ///
  /// In en, this message translates to:
  /// **'Certificate of completion'**
  String get certificateOfCompletion;

  /// No description provided for @skillLevel.
  ///
  /// In en, this message translates to:
  /// **'SKILL LEVEL'**
  String get skillLevel;

  /// No description provided for @prerequisities.
  ///
  /// In en, this message translates to:
  /// **'Prerequisites'**
  String get prerequisities;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @timeToComplete.
  ///
  /// In en, this message translates to:
  /// **'Time to complete'**
  String get timeToComplete;

  /// No description provided for @skilllsUWillGain.
  ///
  /// In en, this message translates to:
  /// **'Skills you’ll gain'**
  String get skilllsUWillGain;

  /// No description provided for @clearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get clearFilter;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get allCategories;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @withCertificate.
  ///
  /// In en, this message translates to:
  /// **'With certificate'**
  String get withCertificate;

  /// No description provided for @onlyFree.
  ///
  /// In en, this message translates to:
  /// **'Only free'**
  String get onlyFree;

  /// No description provided for @newCourses.
  ///
  /// In en, this message translates to:
  /// **'New courses'**
  String get newCourses;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @shopOurSale.
  ///
  /// In en, this message translates to:
  /// **'Shop our sale'**
  String get shopOurSale;

  /// No description provided for @weHaveGotLearning.
  ///
  /// In en, this message translates to:
  /// **'We’ve got learning for all skill levels. Get courses from 99 000 UZS.'**
  String get weHaveGotLearning;

  /// No description provided for @dayLeft.
  ///
  /// In en, this message translates to:
  /// **'day left!'**
  String get dayLeft;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'days left!'**
  String get daysLeft;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @learningStatisctics.
  ///
  /// In en, this message translates to:
  /// **'Learning Statistics'**
  String get learningStatisctics;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @myLearning.
  ///
  /// In en, this message translates to:
  /// **'My Learning'**
  String get myLearning;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @videoPreferences.
  ///
  /// In en, this message translates to:
  /// **'Video preferences'**
  String get videoPreferences;

  /// No description provided for @downloadOptions.
  ///
  /// In en, this message translates to:
  /// **'Download options'**
  String get downloadOptions;

  /// No description provided for @videoPlayBackOptions.
  ///
  /// In en, this message translates to:
  /// **'Video playback options'**
  String get videoPlayBackOptions;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountSettings;

  /// No description provided for @accountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account security'**
  String get accountSecurity;

  /// No description provided for @learningReminders.
  ///
  /// In en, this message translates to:
  /// **'Learning reminders'**
  String get learningReminders;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email notification preferences'**
  String get emailNotifications;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @fonSizeInSteps.
  ///
  /// In en, this message translates to:
  /// **'Font size in steps'**
  String get fonSizeInSteps;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get helpAndSupport;

  /// No description provided for @frequesntlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get frequesntlyAskedQuestions;

  /// No description provided for @aboutEdulab.
  ///
  /// In en, this message translates to:
  /// **'About Edulab'**
  String get aboutEdulab;

  /// No description provided for @priacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy settings'**
  String get priacySettings;

  /// No description provided for @showYourProfileToLoggedUsers.
  ///
  /// In en, this message translates to:
  /// **'Show your profile to logged-in users'**
  String get showYourProfileToLoggedUsers;

  /// No description provided for @showCoursesYouAreTaking.
  ///
  /// In en, this message translates to:
  /// **'Show courses you\'re taking on your profile page'**
  String get showCoursesYouAreTaking;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get noResults;

  /// No description provided for @noInternetC.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetC;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @pleaseCheck.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get pleaseCheck;

  /// No description provided for @markAsComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as complete'**
  String get markAsComplete;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev.'**
  String get prev;

  /// No description provided for @totalTimeLearning.
  ///
  /// In en, this message translates to:
  /// **'Total time learning'**
  String get totalTimeLearning;

  /// No description provided for @courseInProgress.
  ///
  /// In en, this message translates to:
  /// **'Courses in progress'**
  String get courseInProgress;

  /// No description provided for @courseCompleted.
  ///
  /// In en, this message translates to:
  /// **'Courses completed'**
  String get courseCompleted;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @newsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'News will appear here'**
  String get newsWillAppear;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @enrollToThisCourse.
  ///
  /// In en, this message translates to:
  /// **'Enroll to this course'**
  String get enrollToThisCourse;

  /// No description provided for @learnWithLeti.
  ///
  /// In en, this message translates to:
  /// **'Learn with Leti — Start Your Journey Today'**
  String get learnWithLeti;

  /// No description provided for @exploreHighQuality.
  ///
  /// In en, this message translates to:
  /// **'Explore high-quality courses across different fields. Begin today — more subjects are coming soon.'**
  String get exploreHighQuality;

  /// No description provided for @joinForFree.
  ///
  /// In en, this message translates to:
  /// **'Join for free'**
  String get joinForFree;

  /// No description provided for @ourCourses.
  ///
  /// In en, this message translates to:
  /// **'Our courses'**
  String get ourCourses;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @noCoursesFound.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get noCoursesFound;

  /// No description provided for @keepLearning.
  ///
  /// In en, this message translates to:
  /// **'Keep learning - your courses will appear here'**
  String get keepLearning;

  /// No description provided for @browseCourses.
  ///
  /// In en, this message translates to:
  /// **'Browse Courses'**
  String get browseCourses;

  /// No description provided for @welcometoLeti.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Leti'**
  String get welcometoLeti;

  /// No description provided for @continueLearningAndGrowing.
  ///
  /// In en, this message translates to:
  /// **'Continue learning and growing with Leti.'**
  String get continueLearningAndGrowing;

  /// No description provided for @pleseEnterFirstLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first and last name.'**
  String get pleseEnterFirstLastName;

  /// No description provided for @yourRequestSuccessManagerWillContact.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent successfully. Our manager will contact you shortly.'**
  String get yourRequestSuccessManagerWillContact;

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @singInToAccess.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your courses, track progress, and continue learning.'**
  String get singInToAccess;

  /// No description provided for @allCourses.
  ///
  /// In en, this message translates to:
  /// **'All courses'**
  String get allCourses;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! 🎉'**
  String get congratulations;

  /// No description provided for @youhavesuccessfully.
  ///
  /// In en, this message translates to:
  /// **'You’ve successfully completed the quiz and scored'**
  String get youhavesuccessfully;

  /// No description provided for @tryagain.
  ///
  /// In en, this message translates to:
  /// **'Try Again 💪'**
  String get tryagain;

  /// No description provided for @youscored.
  ///
  /// In en, this message translates to:
  /// **'You scored'**
  String get youscored;

  /// No description provided for @pointsAnd.
  ///
  /// In en, this message translates to:
  /// **'points and didn’t pass the quiz this time.'**
  String get pointsAnd;

  /// No description provided for @selectAllCorrectAnswers.
  ///
  /// In en, this message translates to:
  /// **'Select all correct answers'**
  String get selectAllCorrectAnswers;

  /// No description provided for @watchExplanation.
  ///
  /// In en, this message translates to:
  /// **'Watch explanation'**
  String get watchExplanation;

  /// No description provided for @retakeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Retake quiz'**
  String get retakeQuiz;

  /// No description provided for @videoNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Video not available'**
  String get videoNotAvailable;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'off'**
  String get off;

  /// No description provided for @maintenanceInProgress.
  ///
  /// In en, this message translates to:
  /// **'Maintenance in progress'**
  String get maintenanceInProgress;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
