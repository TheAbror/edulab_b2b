import 'package:chopper/chopper.dart';
import 'package:edulab_b2b/widget_imports.dart';

part 'profile_services.chopper.dart';

@ChopperApi(baseUrl: AppStrings.baseLive)
abstract class ProfileServices extends ChopperService {
  static ProfileServices create([ChopperClient? client]) =>
      _$ProfileServices(client ?? ChopperClient());

  @Put(path: AppStrings.profile)
  Future<Response<ProfileResponse>> updateProfile(
    @Body() ProfileUpdateRequest body,
  );
}
