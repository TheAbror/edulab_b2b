import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

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
}
