import 'package:flutter/cupertino.dart';

///Custom [CupertinoPageRoute] to ensure gestures
class CustomCupertinoStyleNavigationRoute extends CupertinoPageRoute {
  @override
  bool get hasScopedWillPopCallback => false;

  // ignore: use_super_parameters
  CustomCupertinoStyleNavigationRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}
