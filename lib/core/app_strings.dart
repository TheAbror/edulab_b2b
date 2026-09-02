class AppStrings {
  /// Everything under `/api/v1/core/`. Most endpoints live under the `mobile/`
  /// sub-path ([baseLive]), but media upload sits directly under core.
  static const baseCore =
      'https://7e3e-213-230-79-129.ngrok-free.app/edulab/api/v1/core/';

  static const baseLive = '${baseCore}mobile/';

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

  //profile
  static const profile = 'profile/';

  static const mediaUpload = '${baseCore}media/upload/mobile';

  /// Name of the multipart part holding the file.
  static const mediaUploadFilePart = 'file';

  /// Required `type` query param on the media upload. Swagger declares it as a
  /// free-form string with no enum, so this is the value we send for avatars -
  /// change it here if the backend rejects it.
  static const mediaTypeProfilePhoto = 'PROFILE_PHOTO';

  //others
  static const internalErrorMessage = 'Internal error';
  static const appVersions = 'settings/versions';
}
// Authorized:
// Get courses: ....../course/
// Get own courses: ......../course/own

// Unauthorized:
// Get courses: ........../public/course/all
