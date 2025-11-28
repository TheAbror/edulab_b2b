import 'package:leti_mobile/widget_imports.dart';

// final customColors = Theme.of(context).extension<CustomColors>()!;

// Container(
//   color: customColors.containerDefault,
//   child: Text(
//     'Hello',
//     style: Theme.of(context).textTheme.bodyMedium,
//   ),
// );

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color float;
  final Color borderMuted;
  final Color accentMuted;
  final Color accentContainerDefault;
  final Color accentContainerSoft;
  final Color neutralDefault;
  final Color neutralOnContainer;
  final Color accentOnContainer;
  final Color neutralContainerDefault;
  final Color neutralContainerSoft;
  final Color fgMuted;
  final Color fgDefault;
  final Color fgDisabled;
  final Color fgSoft;
  final Color bgPage1;
  final Color bgSurface1;
  final Color bgSurface3;
  final Color bgSurface4;
  final Color successDefault;
  final Color infoDefault;
  final Color status03ContainerDefault;
  final Color gradientContainer01Start;
  final Color gradientContainer01End;
  final Color status06ContainerDefault;
  final Color containerDefault;
  final Color accentOnAccent;
  final Color staticTransparent;

  const CustomColors({
    required this.float,
    required this.borderMuted,
    required this.accentMuted,
    required this.accentContainerDefault,
    required this.accentContainerSoft,
    required this.neutralDefault,
    required this.neutralOnContainer,
    required this.accentOnContainer,
    required this.neutralContainerDefault,
    required this.neutralContainerSoft,
    required this.fgMuted,
    required this.fgDefault,
    required this.fgDisabled,
    required this.fgSoft,
    required this.bgPage1,
    required this.bgSurface1,
    required this.bgSurface3,
    required this.bgSurface4,
    required this.successDefault,
    required this.infoDefault,
    required this.status03ContainerDefault,
    required this.gradientContainer01Start,
    required this.gradientContainer01End,
    required this.status06ContainerDefault,
    required this.containerDefault,
    required this.accentOnAccent,
    required this.staticTransparent,
  });

  @override
  CustomColors copyWith({
    Color? float,
    Color? borderMuted,
    Color? accentMuted,
    Color? accentContainerDefault,
    Color? accentContainerSoft,
    Color? neutralDefault,
    Color? neutralOnContainer,
    Color? accentOnContainer,
    Color? neutralContainerDefault,
    Color? neutralContainerSoft,
    Color? fgMuted,
    Color? fgDefault,
    Color? fgDisabled,
    Color? fgSoft,
    Color? bgPage1,
    Color? bgSurface1,
    Color? bgSurface3,
    Color? bgSurface4,
    Color? successDefault,
    Color? infoDefault,
    Color? status03ContainerDefault,
    Color? gradientContainer01Start,
    Color? gradientContainer01End,
    Color? status06ContainerDefault,
    Color? containerDefault,
    Color? accentOnAccent,
    Color? staticTransparent,
  }) {
    return CustomColors(
      float: float ?? this.float,
      borderMuted: borderMuted ?? this.borderMuted,
      accentMuted: accentMuted ?? this.accentMuted,
      accentContainerDefault:
          accentContainerDefault ?? this.accentContainerDefault,
      accentContainerSoft: accentContainerSoft ?? this.accentContainerSoft,
      neutralDefault: neutralDefault ?? this.neutralDefault,
      neutralOnContainer: neutralOnContainer ?? this.neutralOnContainer,
      accentOnContainer: accentOnContainer ?? this.accentOnContainer,
      neutralContainerDefault:
          neutralContainerDefault ?? this.neutralContainerDefault,
      neutralContainerSoft: neutralContainerSoft ?? this.neutralContainerSoft,
      fgMuted: fgMuted ?? this.fgMuted,
      fgDefault: fgDefault ?? this.fgDefault,
      fgDisabled: fgDisabled ?? this.fgDisabled,
      fgSoft: fgSoft ?? this.fgSoft,
      bgPage1: bgPage1 ?? this.bgPage1,
      bgSurface1: bgSurface1 ?? this.bgSurface1,
      bgSurface3: bgSurface3 ?? this.bgSurface3,
      bgSurface4: bgSurface4 ?? this.bgSurface4,
      successDefault: successDefault ?? this.successDefault,
      infoDefault: infoDefault ?? this.infoDefault,
      status03ContainerDefault:
          status03ContainerDefault ?? this.status03ContainerDefault,
      gradientContainer01Start:
          gradientContainer01Start ?? this.gradientContainer01Start,
      gradientContainer01End:
          gradientContainer01End ?? this.gradientContainer01End,
      status06ContainerDefault:
          status06ContainerDefault ?? this.status06ContainerDefault,
      containerDefault: containerDefault ?? this.containerDefault,
      accentOnAccent: accentOnAccent ?? this.accentOnAccent,
      staticTransparent: staticTransparent ?? this.staticTransparent,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      float: Color.lerp(float, other.float, t)!,
      borderMuted: Color.lerp(borderMuted, other.borderMuted, t)!,
      accentMuted: Color.lerp(accentMuted, other.accentMuted, t)!,
      accentContainerDefault: Color.lerp(
        accentContainerDefault,
        other.accentContainerDefault,
        t,
      )!,
      neutralDefault: Color.lerp(neutralDefault, other.neutralDefault, t)!,
      neutralOnContainer: Color.lerp(
        neutralOnContainer,
        other.neutralOnContainer,
        t,
      )!,
      accentContainerSoft: Color.lerp(
        accentContainerSoft,
        other.accentContainerSoft,
        t,
      )!,
      accentOnContainer: Color.lerp(
        accentOnContainer,
        other.accentOnContainer,
        t,
      )!,
      fgMuted: Color.lerp(fgMuted, other.fgMuted, t)!,
      neutralContainerDefault: Color.lerp(
        neutralContainerDefault,
        other.neutralContainerDefault,
        t,
      )!,
      neutralContainerSoft: Color.lerp(
        neutralContainerSoft,
        other.neutralContainerSoft,
        t,
      )!,
      fgDefault: Color.lerp(fgDefault, other.fgDefault, t)!,
      fgDisabled: Color.lerp(fgDisabled, other.fgDisabled, t)!,
      fgSoft: Color.lerp(fgSoft, other.fgSoft, t)!,
      bgPage1: Color.lerp(bgPage1, other.bgPage1, t)!,
      bgSurface1: Color.lerp(bgSurface1, other.bgSurface1, t)!,
      bgSurface3: Color.lerp(bgSurface3, other.bgSurface3, t)!,
      bgSurface4: Color.lerp(bgSurface4, other.bgSurface4, t)!,
      successDefault: Color.lerp(successDefault, other.successDefault, t)!,
      infoDefault: Color.lerp(infoDefault, other.infoDefault, t)!,
      status03ContainerDefault: Color.lerp(
        status03ContainerDefault,
        other.status03ContainerDefault,
        t,
      )!,
      gradientContainer01Start: Color.lerp(
        gradientContainer01Start,
        other.gradientContainer01Start,
        t,
      )!,
      gradientContainer01End: Color.lerp(
        gradientContainer01End,
        other.gradientContainer01End,
        t,
      )!,
      status06ContainerDefault: Color.lerp(
        status06ContainerDefault,
        other.status06ContainerDefault,
        t,
      )!,
      containerDefault: Color.lerp(
        containerDefault,
        other.containerDefault,
        t,
      )!,
      accentOnAccent: Color.lerp(accentOnAccent, other.accentOnAccent, t)!,
      staticTransparent: Color.lerp(
        staticTransparent,
        other.staticTransparent,
        t,
      )!,
    );
  }
}
