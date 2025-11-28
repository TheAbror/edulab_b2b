part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isDialogShownFirstTime;
  final int tabIndex;
  final bool isLightTheme;
  final bool isSystemDefault;
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
    required this.isSystemDefault,
    required this.blocProgress,
    required this.failureMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      tabIndex: 0,
      isDialogShownFirstTime: true,
      isLightTheme: true,
      isSystemDefault: true,
      teachers: [
        TeacherModel(
          id: 1,
          firstname: 'John',
          lastname: 'Doe',
          job_title: 'Senior Software Engineer',
          about_me:
              'John has over 10 years of experience in software development and specializes in Flutter development.',
          average_rating: 4.8,
          courses_number: 5,
          total_reviews_number: 1200,
          total_students_number: 15000,
          roles: ['Instructor', 'Mentor'],
          profile_picture: TeacherProfilePictureModel(
            original_url:
                'https://onlinecoursesgalore.com/wp-content/uploads/2017/04/Jose-Portilla-top-instructor-udemy.jpg',
            pic_extension: '',
            file_size: 0,
            original_name: '',
            src: '',
            thumb_url: '',
            url: '',
          ),
        ),
        TeacherModel(
          id: 2,
          firstname: 'Jane',
          lastname: 'Smith',
          job_title: 'Data Scientist',
          about_me:
              'Jane is a seasoned data scientist with a passion for teaching and sharing her knowledge in data analytics and machine learning.',
          average_rating: 4.9,
          courses_number: 3,
          total_reviews_number: 900,
          total_students_number: 10000,
          roles: ['Instructor', 'Author'],
          profile_picture: TeacherProfilePictureModel(
            original_url: 'https://img-c.udemycdn.com/user/200_H/31334738_a13c_3.jpg',
            pic_extension: '',
            file_size: 0,
            original_name: '',
            src: '',
            thumb_url: '',
            url: '',
          ),
        ),
        TeacherModel(
          id: 3,
          firstname: 'Alice',
          lastname: 'Johnson',
          job_title: 'UI/UX Designer',
          about_me:
              'Alice is an experienced UI/UX designer who has worked with several high-profile clients and loves to teach design principles and techniques.',
          average_rating: 4.7,
          courses_number: 4,
          total_reviews_number: 800,
          total_students_number: 8000,
          roles: ['Instructor', 'Designer'],
          profile_picture: TeacherProfilePictureModel(
            original_url: 'https://www.spencerclarkegroup.co.uk/uploads/5005001.png',
            pic_extension: '',
            file_size: 0,
            original_name: '',
            src: '',
            thumb_url: '',
            url: '',
          ),
        ),
      ],
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
    bool? isSystemDefault,
    List<TeacherModel>? teachers,
    TeacherModel? teachersById,
    BlocProgress? blocProgress,
    String? failureMessage,
  }) {
    return HomeState(
      isDialogShownFirstTime: isDialogShownFirstTime ?? this.isDialogShownFirstTime,
      tabIndex: tabIndex ?? this.tabIndex,
      isLightTheme: isLightTheme ?? this.isLightTheme,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
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
        isSystemDefault,
        teachers,
        teachersById,
        blocProgress,
        failureMessage,
      ];
}
