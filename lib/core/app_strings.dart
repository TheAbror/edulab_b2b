class AppStrings {
  static const baseLive =
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/';

  static const projetName = 'EduLab';
  //auth
  static const signUP = 'signup';
  static const signIn = 'signin';
  static const course = 'course';
  static const coursesAll = '$course/all';
  static const categoryAll = 'category/all';
  static const currentCourse = '$course/own?limit=1';
  static const learningTabInProgress = '$course/own?status=IN_PROGRESS';
  static const learningTabCompleted = '$course/own?status=COMPLETED';
  static const learningTabFavorites = '$course/own?status=FAVORITES';
  static const statistics = 'statistics/';
  static const addToFavorite = '$course/add-to-favorites';
  static const learningWithID = 'learning/';

  //
  static const sendVerification = 'verify_code/send';
  static const updatePassword = 'update_password';
  static const createNewPassword = 'reset_password';
  //others
  static const teacher = 'teacher/';
  static const certificate = 'certificate/';
  static const internalErrorMessage = 'Internal error';
}


//https://leti.slash.uz/edulab_corp/api/v1/core/learning/?chapter_id=188&course_id=187&step_id=204&topic_id=192