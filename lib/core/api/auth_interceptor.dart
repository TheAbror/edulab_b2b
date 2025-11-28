import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:leti_mobile/core/local_datasource/widgets/datasource_widgets.dart';

// class NotAuthorizedInterceptor implements ResponseInterceptor {
//   final StreamController<bool> controller = StreamController<bool>.broadcast();

//   @override
//   FutureOr<Response> onResponse(Response response) {
//     CurrentUser? userData = userBox.get(ShPrefKeys.currentUser);
//     final token = userData?.token;

//     if (token != null && token.isNotEmpty) {
//       if (response.statusCode == 401) {
//         controller.add(true);
//       }
//     }

//     return response;
//   }
// }
