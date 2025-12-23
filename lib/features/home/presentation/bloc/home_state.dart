part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isDialogShownFirstTime;
  final int tabIndex;
  final bool isLightTheme;
  final InternetStatus internetStatus;
  final List<TeacherModel> teachers;
  final TeacherModel teachersById;
  final BlocProgress blocProgress;
  final String failureMessage;

  const HomeState({
    required this.teachers,
    required this.teachersById,
    required this.tabIndex,
    required this.isDialogShownFirstTime,
    required this.isLightTheme,
    required this.internetStatus,

    required this.blocProgress,
    required this.failureMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      tabIndex: 0,
      isDialogShownFirstTime: true,
      isLightTheme: true,
      internetStatus: InternetStatus.connected,
      teachers: [],
      teachersById: TeacherModel(
        id: 0,
        firstname: 'John',
        lastname: 'Doe',
        job_title: '',
        about_me: '',
        average_rating: 0,
        courses_number: 0,
        total_reviews_number: 0,
        total_students_number: 0,
        roles: [],
        profile_picture: TeacherProfilePictureModel(
          original_url:
              'https://www.springboard.com/blog/wp-content/uploads/2022/11/15-jobs-for-former-teachers-to-consider-in-2023.jpg',
          pic_extension: '',
          file_size: 0,
          original_name: '',
          src: '',
          thumb_url: '',
          url: '',
        ),
      ),
      blocProgress: BlocProgress.NOT_STARTED,
      failureMessage: '',
    );
  }

  HomeState copyWith({
    bool? isDialogShownFirstTime,
    int? tabIndex,
    bool? isLightTheme,
    InternetStatus? internetStatus,
    List<TeacherModel>? teachers,
    TeacherModel? teachersById,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return HomeState(
      isDialogShownFirstTime:
          isDialogShownFirstTime ?? this.isDialogShownFirstTime,
      tabIndex: tabIndex ?? this.tabIndex,
      isLightTheme: isLightTheme ?? this.isLightTheme,
      internetStatus: internetStatus ?? this.internetStatus,

      teachers: teachers ?? this.teachers,
      teachersById: teachersById ?? this.teachersById,
      blocProgress: blocProgress ?? this.blocProgress,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    isDialogShownFirstTime,
    tabIndex,
    isLightTheme,
    internetStatus,
    teachers,
    teachersById,
    blocProgress,
    failureMessage,
  ];
}
