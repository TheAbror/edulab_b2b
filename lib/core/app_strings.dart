class AppStrings {
  static const baseLive =
      'https://leti.slash.uz/edulab_corp/api/v1/core/mobile/';

  static const projetName = 'EduLab';

  //auth
  static const signUP = 'signup';
  static const sendVerification = 'verify_code/send';
  static const signInStepOne = 'signin/step_one';
  static const signInStepTwo = 'signin/step_two';
  static const signInStepThree = 'signin/step_three';

  static const coursesAll = '$course/all';
  static const learningTabInProgress = '$course/own?status=IN_PROGRESS';
  static const learningTabCompleted = '$course/own?status=COMPLETED';
  static const statistics = 'statistics/';
  static const addToFavorite = '$course/add-to-favorites';
  static const learningWithID = 'learning/';
  static const submitQuiz = 'learning/submit';
  static const checkEnrollment = 'enrollment/check';
  static const enrollToCourse = 'enrollment/';
  static const completeStep = 'learning/complete';
  //authorized
  static const course = 'course';
  static const currentCourse = '$course/own';
  //unauthorized
  static const currentCourseAsUnauthorized = 'public/course/all';
  static const courseAsUnauthorized = 'public/course';

  //others
  static const internalErrorMessage = 'Internal error';
  static const appVersions = 'settings/versions';
}
// Authorized:
// Get courses: ....../course/
// Get own courses: ......../course/own

// Unauthorized:
// Get courses: ........../public/course/all
