import 'package:chopper/chopper.dart';
import 'package:leti_mobile/widget_imports.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) =>
      _$AuthService(client ?? ChopperClient());

  @Post(path: AppStrings.signInStepOne)
  Future<Response<MobileResponse>> signInStepOne(
    @Body() SignInStepOneRequest body,
  );

  @Post(path: AppStrings.signInStepTwo)
  Future<Response<AuthResponse>> signInStepTwo(
    @Body() SignInStepTwoRequest body,
  );

  @Post(path: AppStrings.signInStepThree)
  Future<Response<AuthResponse>> signInStepThree(
    @Body() SignInStepThreeRequest body,
  );

  @Post(path: AppStrings.sendVerification)
  Future<Response<MobileResponse>> sendSignUpKeyForVerification(
    @Body() SignUpKeyRequest body,
  );

  @Post(path: AppStrings.updatePassword)
  Future<Response<MobileResponse>> getVerificationCodeBySendingLogin(
    @Body() GetVerificationCodeBySendingLogin body,
  );

  @Post(path: AppStrings.createNewPassword)
  Future<Response<AuthResponse>> resetPasswordToNew(
    @Body() ResetPasswordToNew body,
  );
}
