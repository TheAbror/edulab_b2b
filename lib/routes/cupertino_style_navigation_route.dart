import 'package:flutter/cupertino.dart';

///Custom [CupertinoPageRoute] to ensure gestures
///
///[T] is the type the route pops with; it defaults to dynamic, so the named
///routes in MainRouteGenerator can keep constructing it without a type
///argument while screens that return a value can ask for one.
class CustomCupertinoStyleNavigationRoute<T> extends CupertinoPageRoute<T> {
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
